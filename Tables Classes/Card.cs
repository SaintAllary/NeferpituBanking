using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Tables_Classes
{
    public class Card : GET_AllUsersCards_Result
    {
        public ObservableCollection<GET_AllTransactions_Result> Transctions { get; set; }
        public GET_CardState_Result State { get; set; }
       public string Type { get; set; }
       public GET_CardLimits_Result CardLimit { get; set; }
       public GET_CardBalance_Result GET_CardBalance_Result { get; set; }
       public GET_PrivateCardInfo_Result CardPrivate { get; set; }

       public GET_PaymentCompany_Result PaymentCompany { get; set; }
       public Card(GET_AllUsersCards_Result card,GET_PrivateCardInfo_Result cardPrivate)
        {
           
            this.Account_Id = card.Account_Id;
            this.BankName_Card = card.BankName_Card;
            this.CardBalance_Id = card.CardBalance_Id;
            this.CardLimits_Id = card.CardLimits_Id;
            this.CardState_Id = card.CardState_Id;
            this.Code_Card = card.Code_Card;
            this.Id_Card = card.Id_Card;
            this.CardPrivate = cardPrivate;

            //CardPrivate.ExpireDate_CardPrivate
            Transctions = new ObservableCollection<GET_AllTransactions_Result>() {};
        }

        public override string ToString()
        {
            return this.Code_Card.ToString();
        }
    }
}
