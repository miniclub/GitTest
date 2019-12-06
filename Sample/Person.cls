/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// This sample persistent class represents a person.
Class Sample.Person Extends (%Persistent, %Populate, %XML.Adaptor)
{

Parameter EXTENTQUERYSPEC = "Name,SSN,Home.City,Home.State";

/// Define a unique index for <property>SSN</property>.
Index SSNKey On SSN [ Type = index, Unique ];

/// Define an index for <property>Name</property>.
Index NameIDX On Name [ Data = Name ];

/// Define an index for embedded object property <b>ZipCode</b>.
Index ZipCode On Home.Zip [ Type = bitmap ];

/// Person's name.
Property Name As %String(POPSPEC = "Name()") [ Required ];

/// Person's Social Security number. This is validated using pattern match.
Property SSN As %String(PATTERN = "3N1""-""2N1""-""4N") [ Required ];

/// Person's Date of Birth.
Property DOB As %Date(POPSPEC = "Date()");

/// Person's home address. This uses an embedded object.
Property Home As Address;

/// Person's office address. This uses an embedded object.
Property Office As Address;

/// Person's spouse. This is a reference to another persistent object.
Property Spouse As Person;

/// A collection of strings representing the person's favorite colors.
Property FavoriteColors As list Of %String(JAVATYPE = "java.util.List", POPSPEC = "ValueList("",Red,Orange,Yellow,Green,Blue,Purple,Black,White""):2");

/// Person's age.<br>
/// This is a calculated field whose value is derived from <property>DOB</property>.
Property Age As %Integer [ Calculated, SqlComputeCode = { Set {Age}=##class(Sample.Person).CurrentAge({DOB})
}, SqlComputed, SqlComputeOnChange = DOB ];

/// This class method calculates a current age given a date of birth <var>date</var>.
/// This method is used by the Age calculated field.
ClassMethod CurrentAge(date As %Date = "") As %Integer [ CodeMode = expression ]
{
$Select(date="":"",1:($ZD($H,8)-$ZD(date,8)\10000))
}

/// A sample class query that defines a result set that returns Person data 
/// ordered by <property>Name</property>.<br>
/// This query can be used within another method (using 
/// dynamic SQL), or it can be used from Java.<br>
/// This query is also accessible from JDBC and/or ODBC as the SQL stored procedure 
/// <b>SP_Sample_By_Name</b>.
Query ByName(name As %String = "") As %SQLQuery(CONTAINID = 1, SELECTMODE = "RUNTIME") [ SqlName = SP_Sample_By_Name, SqlProc ]
{
SELECT ID, Name, DOB, SSN
FROM Sample.Person
WHERE (Name %STARTSWITH :name)
ORDER BY Name
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>SSN</Value>
</Value>
<Value name="4">
<Value>DOB</Value>
</Value>
<Value name="5">
<Value>Home</Value>
</Value>
<Value name="6">
<Value>Office</Value>
</Value>
<Value name="7">
<Value>Spouse</Value>
</Value>
<Value name="8">
<Value>FavoriteColors</Value>
</Value>
</Data>
<DataLocation>^Sample.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>200</ExtentSize>
<IdLocation>^Sample.PersonD</IdLocation>
<IndexLocation>^Sample.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>8.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>2.46</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Age">
<AverageFieldSize>1.92</AverageFieldSize>
<Selectivity>1.2821%</Selectivity>
</Property>
<Property name="DOB">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>0.5025%</Selectivity>
</Property>
<Property name="FavoriteColors">
<AverageFieldSize>7.41</AverageFieldSize>
<OutlierSelectivity>.29:</OutlierSelectivity>
<Selectivity>1.5435%</Selectivity>
</Property>
<Property name="Home">
<AverageFieldSize>36.29,City:7.03,State:2,Street:16.86,Zip:5</AverageFieldSize>
<Selectivity>0.5000%,City:3.8462%,State:2.1277%,Street:0.5000%,Zip:0.5000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>16.27</AverageFieldSize>
<Selectivity>0.5000%</Selectivity>
</Property>
<Property name="Office">
<AverageFieldSize>35.86,City:7.12,State:2,Street:16.34,Zip:5</AverageFieldSize>
<Selectivity>0.5000%,City:3.8462%,State:2.1277%,Street:0.5000%,Zip:0.5000%</Selectivity>
</Property>
<Property name="SSN">
<AverageFieldSize>11</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Spouse">
<AverageFieldSize>.95</AverageFieldSize>
<OutlierSelectivity>.5:</OutlierSelectivity>
<Selectivity>0.7813%</Selectivity>
</Property>
<SQLMap name="$Person">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDKEY">
<BlockCount>-20</BlockCount>
</SQLMap>
<SQLMap name="NameIDX">
<BlockCount>-8</BlockCount>
</SQLMap>
<SQLMap name="SSNKey">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="ZipCode">
<BlockCount>-8</BlockCount>
</SQLMap>
<StreamLocation>^Sample.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

