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
    
    public partial class GET_AllTransactions_Result
    {
        public int Id_Transaction { get; set; }
        public Nullable<decimal> Value_Transaction { get; set; }
        public Nullable<System.DateTime> Date_Transaction { get; set; }
        public Nullable<int> TransactionState_Id { get; set; }
        public Nullable<int> CardOwner_Id { get; set; }
        public Nullable<int> DestionationCard_Id { get; set; }
    }
}