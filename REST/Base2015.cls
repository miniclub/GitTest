Class REST.Base2015 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/:method" Method="POST" Call="Dispatch"/>
</Routes>
}

/// メソッドのディスパッチ
/// 入力形式
///      { "Params":[<パラメータの配列>] }
/// 
/// 出力形式
///      { "Status":<ステータス値>, "Return":<戻り値> }
///      ステータス値 0...失敗, 1...成功
ClassMethod Dispatch(Method As %String) As %Status
{
	//set %request.Content.ContentType="text/json; charset=UTF-8"
	set %response.CharSet="UTF-8"
	set $ztrap="Err"
	set %response.ContentType="text/json"
	// POST形式ならばJSONパラメータを取得する
	set ret=..GetParams(.args)
	quit:$$$ISERR(ret) $$$OK

	if $data(args) {
		set ret=$classmethod(..%ClassName(1),Method,args...)	
	} else {
		set ret=$classmethod(..%ClassName(1),Method)	
	}
	// インスタンスが返ってきたとき、JSON形式に変換
	if $isobject(ret) {
		write "{ ""Return"":"
		if ret.%IsA("%ResultSet") {
			//ResultSetの内容を取得
			write "["
			for j=1:1 {
				quit:'ret.Next()
				write $select(j>1:",",1:""),"{"
				for i=1:1:ret.GetColumnCount() {
					write $select(i>1:",",1:""),"""",ret.GetColumnName(i),""":""",ret.GetData(i),""""
				}
				write "}"
			}
			write "],""Status"": 1}",!
		} else {
			set ret2=##class(%ZEN.Auxiliary.jsonProvider).%ObjectToJSON(ret,.v,0,"tw")
			write $select($$$ISOK(ret2):", ""Status"": 1 }"
				,1:""""", ""Status"": 0, ""ErrorCode"":"""_$SYSTEM.Status.GetErrorCodes(ret2)_""",""ErrorText"":"""_$SYSTEM.Status.GetErrorText(ret)_""" }"),!
		}
		quit $$$OK
	}
	// データタイプが返ってきたとき、戻り値をJSON形式に変換
	write "{ ""Status"":1, ""Return"":"""_ret_""" }",!
		
	quit $$$OK
Err
	set ret=$$$ERROR(5002,$zerror)
	write "{ ""Status"": 0, ""ErrorCode"":""",$SYSTEM.Status.GetErrorCodes(ret),""",""ErrorText"":""",$SYSTEM.Status.GetErrorText(ret),""" }",!
	quit $$$OK
}

/// JSON形式の入力パラメータを読み込む
ClassMethod GetParams(ByRef args) As %Status
{
	kill args
	if $isobject(%request.Content) {
		set ret=##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(%request.Content,,.input)
		if $$$ISERR(ret) {
			write "{ ""Status"": 0, ""ErrorCode"":""",$SYSTEM.Status.GetErrorCodes(ret),""",""ErrorText"":""",$SYSTEM.Status.GetErrorText(ret),""" }",!
			quit ret
		}
		// 変換テーブルの取得
		set trans=##class(%Net.Charset).GetTranslateTable(%request.CharSet)
		
		// パラメータの取得
		set param=$select($isobject(input):input.Params,1:"")
		if $isobject(param)&&param.%IsA("%ListOfDataTypes") {
			set arg="",n=0 for {
				set arg=$order(param.Data(arg),1,data)
				quit:arg=""
				
				set n=n+1,args(n)=$zcvt(data,"I",trans)
			}
			set args=n
		}
	}
	quit $$$OK
}

}

