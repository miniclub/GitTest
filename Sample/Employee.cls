/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// This sample persistent class represents an employee.<br>
Class Sample.Employee Extends Person
{

/// The employee's job title.
Property Title As %String(MAXLEN = 50, POPSPEC = "Title()");

/// The employee's current salary.
Property Salary As %Integer(MAXVAL = 100000, MINVAL = 0);

/// A character stream containing notes about this employee.
Property Notes As %Stream.GlobalCharacter;

/// A picture of the employee
Property Picture As %Stream.GlobalBinary;

/// The company this employee works for.
Relationship Company As Company [ Cardinality = one, Inverse = Employees ];

/// Writes a .png file containing the picture, if any, of this employee
/// the purpose of this method is to prove that Picture really contains an image
Method WritePicture()
{
	if (..Picture="") {quit}
	set name=$TR(..Name,".") ; strip off trailing period
	set name=$TR(name,", ","__") ; replace commas and spaces
	set filename=name_".png"
	
	set file=##class(%Stream.FileBinary).%New()
	set file.Filename=filename
	do file.CopyFrom(..Picture)
	do file.%Save()
	write !, "Generated file: "_filename
}

Storage Default
{
<Data name="EmployeeDefaultData">
<Subscript>"Employee"</Subscript>
<Value name="1">
<Value>Company</Value>
</Value>
<Value name="2">
<Value>Notes</Value>
</Value>
<Value name="3">
<Value>Salary</Value>
</Value>
<Value name="4">
<Value>Title</Value>
</Value>
<Value name="5">
<Value>Picture</Value>
</Value>
</Data>
<DefaultData>EmployeeDefaultData</DefaultData>
<ExtentSize>100</ExtentSize>
<Property name="%%CLASSNAME">
<AverageFieldSize>17</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Age">
<AverageFieldSize>1.92</AverageFieldSize>
<Selectivity>1.6393%</Selectivity>
</Property>
<Property name="Company">
<AverageFieldSize>1.62</AverageFieldSize>
<Selectivity>5.0000%</Selectivity>
</Property>
<Property name="DOB">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="FavoriteColors">
<AverageFieldSize>7.3</AverageFieldSize>
<OutlierSelectivity>.31:</OutlierSelectivity>
<Selectivity>1.9714%</Selectivity>
</Property>
<Property name="Home">
<AverageFieldSize>36.29,City:6.74,State:2,Street:17.12,Zip:5</AverageFieldSize>
<Selectivity>1.0000%,City:4.0000%,State:2.3256%,Street:1.0000%,Zip:1.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>16.24</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="Notes">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Office">
<AverageFieldSize>35.83,City:7.13,State:2,Street:16.26,Zip:5</AverageFieldSize>
<Selectivity>1.0000%,City:3.8462%,State:2.5641%,Street:1.0000%,Zip:1.0000%</Selectivity>
</Property>
<Property name="Picture">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="SSN">
<AverageFieldSize>11</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Salary">
<AverageFieldSize>4.91</AverageFieldSize>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="Spouse">
<AverageFieldSize>1.9</AverageFieldSize>
<Selectivity>1.5625%</Selectivity>
</Property>
<Property name="Title">
<AverageFieldSize>21.06</AverageFieldSize>
<Selectivity>1.3514%</Selectivity>
</Property>
<SQLMap name="$Employee">
<BlockCount>-4</BlockCount>
</SQLMap>
<Type>%Storage.Persistent</Type>
}

}

