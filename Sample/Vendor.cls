/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// The <class>Vendor</class> class is a persistent class 
/// containing vendor information.<br>
/// This class demonstrates how to use the <class>%CacheSQLStorage</class> storage 
/// class to provide custom storage for a persistent class. Typically the 
/// <class>%CacheSQLStorage</class> storage class is used to provide object access 
/// to previously existing storage structures.
Class Sample.Vendor Extends (%Persistent, %Populate, %XML.Adaptor) [ SqlRowIdName = Vendor, StorageStrategy = SQLStorage ]
{

/// Name Index
Index IndexNName On Name;

/// Vendor name.
Property Name As %String(POPSPEC = "Company()");

/// Vendor address.
Property Address As Address(POPSPEC = "##class(Address).PopulateSerial()");

/// Name of primary vendor contact.
Property Contact As %String(POPSPEC = "Name()");

/// Discount rate.
Property DiscRate As %Float(MAXVAL = 100, MINVAL = 0);

/// Discount days.
Property DiscDays As %Integer(MAXVAL = 999, MINVAL = 0);

/// Net days.
Property NetDays As %Integer(MAXVAL = 999, MINVAL = 0);

/// Days clear.
Property DaysClear As %Integer(MAXVAL = 999, MINVAL = 0);

/// Payment Flag
Property PayFlag As %String(DISPLAYLIST = ",Never,Minimum", VALUELIST = ",N,M");

/// Minimum Payment.
Property MinPayment As %Float(MAXVAL = 999999, MINVAL = 0);

/// Last Invoice Date.
Property LastInvDate As %Date(MAXVAL = "", MINVAL = "");

/// Last Payment Date.
Property LastPayDate As %Date(MAXVAL = "", MINVAL = "");

/// Balance.
Property Balance As %Float(MAXVAL = 999999999, MINVAL = -999999999);

/// Vendor tax reporting status.
Property TaxReporting As %String(DISPLAYLIST = ",Exempt,Required", VALUELIST = ",E,");

Storage SQLStorage
{
<ExtentSize>100</ExtentSize>
<Property name="%%ID">
<AverageFieldSize>1.92</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Address">
<AverageFieldSize>36.44,City:7.34,State:2,Street:16.69,Zip:5</AverageFieldSize>
<Selectivity>1.0000%,City:3.8462%,State:2.3810%,Street:1.0000%,Zip:1.0000%</Selectivity>
</Property>
<Property name="Balance">
<AverageFieldSize>9.4</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="Contact">
<AverageFieldSize>15.48</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="DaysClear">
<AverageFieldSize>2.93</AverageFieldSize>
<Selectivity>1.0989%</Selectivity>
</Property>
<Property name="DiscDays">
<AverageFieldSize>2.85</AverageFieldSize>
<Selectivity>1.0204%</Selectivity>
</Property>
<Property name="DiscRate">
<AverageFieldSize>1.86</AverageFieldSize>
<Selectivity>1.6667%</Selectivity>
</Property>
<Property name="LastInvDate">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>1.0101%</Selectivity>
</Property>
<Property name="LastPayDate">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="MinPayment">
<AverageFieldSize>5.89</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>17.59</AverageFieldSize>
<Selectivity>1.0101%</Selectivity>
</Property>
<Property name="NetDays">
<AverageFieldSize>2.83</AverageFieldSize>
<Selectivity>1.0309%</Selectivity>
</Property>
<Property name="PayFlag">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="TaxReporting">
<AverageFieldSize>.55</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SqlIdExpression>$i(^Sample.VendorD)</SqlIdExpression>
<SQLMap name="DataMasterMap">
<BlockCount>-8</BlockCount>
<Data name="Address">
<Piece>2</Piece>
</Data>
<Data name="Balance">
<Node>1</Node>
<Piece>3</Piece>
</Data>
<Data name="Contact">
<Piece>3</Piece>
</Data>
<Data name="DaysClear">
<Piece>7</Piece>
</Data>
<Data name="DiscDays">
<Piece>5</Piece>
</Data>
<Data name="DiscRate">
<Piece>4</Piece>
</Data>
<Data name="LastInvDate">
<Node>1</Node>
<Piece>1</Piece>
</Data>
<Data name="LastPayDate">
<Node>1</Node>
<Piece>2</Piece>
</Data>
<Data name="MinPayment">
<Piece>9</Piece>
</Data>
<Data name="Name">
<Piece>1</Piece>
</Data>
<Data name="NetDays">
<Piece>6</Piece>
</Data>
<Data name="PayFlag">
<Piece>8</Piece>
</Data>
<Data name="TaxReporting">
<Piece>10</Piece>
</Data>
<Global>^Sample.DataD</Global>
<Structure>list</Structure>
<Subscript name="1">
<Expression>{Vendor}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<SQLMap name="IndexNName">
<BlockCount>-4</BlockCount>
<Global>^Sample.VendorI</Global>
<Structure>list</Structure>
<Subscript name="1">
<Expression>"N"</Expression>
</Subscript>
<Subscript name="2">
<Expression>$$SQLUPPER({Name})</Expression>
</Subscript>
<Subscript name="3">
<Expression>{Vendor}</Expression>
</Subscript>
<Type>index</Type>
</SQLMap>
<StreamLocation>^Sample.VendorS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}

