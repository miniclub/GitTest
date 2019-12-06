Class REST.Test2015 Extends REST.Base2015
{

ClassMethod OpenPerson(id As %String) As Sample.Person
{
	set obj=##class(Sample.Person).%OpenId(id)
	quit obj
}

ClassMethod SearchPerson(Name As %String) As %ResultSet
{
	set rs=##class(%ResultSet).%New()
	do rs.Prepare("SELECT * from Sample.Person WHERE Name %Startswith ?")
	do rs.Execute(Name)
	quit rs
}

ClassMethod OpenCompany() As Sample.Company
{
	set obj=##class(Sample.Company).%OpenId(1)
	quit obj
}

}

