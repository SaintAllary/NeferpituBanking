//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace NeferpituBanking
{
    using System;
    
    public partial class GET_AccountInfo_Result
    {
        public int Id_Account { get; set; }
        public string Name_Account { get; set; }
        public string Surname_Account { get; set; }
        public Nullable<bool> IsActive_Account { get; set; }
        public string PhotoURL_Account { get; set; }
        public Nullable<int> Pin_Id { get; set; }
        public Nullable<int> AccountStatus_Id { get; set; }
        public Nullable<int> Sex_Account_Id { get; set; }
        public Nullable<int> AccountPrivate_Id { get; set; }
        public Nullable<int> AccountType_Id { get; set; }
        public Nullable<int> Login_Id { get; set; }
        public Nullable<int> Password_Id { get; set; }
        public int Id_AccountPrivate { get; set; }
        public Nullable<System.DateTime> BDate_AccountPrivate { get; set; }
        public string City_AccountPrivate { get; set; }
        public string Street_AccountPrivate { get; set; }
        public string Phone_AccountPrivate { get; set; }
        public string Email_AccountPrivate { get; set; }
        public string PassportINN_AccountPrive { get; set; }
        public Nullable<int> CommercialAccountInfo_Id { get; set; }
        public int Id_CommercialAccountInfo { get; set; }
        public string Education_CommercialAccountInfo { get; set; }
        public Nullable<decimal> OfficialSalary_CommercialAccountInfo { get; set; }
        public Nullable<decimal> UnofficialSalary__CommercialAccountInfo { get; set; }
        public string Position_CommercialAccountInfo { get; set; }
        public int Id_AccountType { get; set; }
        public string Type_AccountType { get; set; }
        public int Id_Status { get; set; }
        public string Value_AccountStatus { get; set; }
    }
}
