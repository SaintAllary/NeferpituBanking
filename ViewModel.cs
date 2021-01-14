using GalaSoft.MvvmLight.Command;
using NeferpituBanking.Exceptions;
using NeferpituBanking.Tables_Classes;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace NeferpituBanking
{

   public class ViewModel : NeferpituBankingEntities, INotifyPropertyChanged
    {

        private ObservableCollection<GET_AllAlerts_Result> alters;
        public ObservableCollection<GET_AllAlerts_Result> Alters {
            get => alters;
            set
            {
                alters = value;
                OnPropertyChanged(nameof(alters));
            }
        }
        

        private TransactionOperation transactionOperation;
        public TransactionOperation TransactionOperation {
            get => transactionOperation;
            set
            {
                transactionOperation = value;
                OnPropertyChanged(nameof(transactionOperation));
            }
        }

     
        private long userId;

        private long UserId {
            get => userId;
            set
            {
                userId = value;
                
            }
        }

        private string password;
        public string Password
        {
            get => password;
            set
            {
                password = value;
                OnPropertyChanged(nameof(password));
            }
        }

        private string login;
        public string Login
        {
            get => login;
            set
            {
                login = value;
                OnPropertyChanged(nameof(login));
            }
        }

        private ObservableCollection<Card> cards;

        public ObservableCollection<Card> Cards
        {
            get => cards; set
            {
                cards = value;
                
            }
        }


        private Card currentCard;
        public Card CurrentCard
        {
            get => currentCard;
            set
            {
                currentCard = value;
                OnPropertyChanged(nameof(currentCard));
            }
        }
  



        public ViewModel()
        {
            cards = new ObservableCollection<Card>();
            TransactionOperation = new TransactionOperation();
            Alters = new ObservableCollection<GET_AllAlerts_Result>();
 
        }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged([CallerMemberName] string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }


        public ICommand UserSignIn => new RelayCommand(() =>
         {
           
             try
             {
                 var obj = new System.Data.Entity.Core.Objects.ObjectParameter(Properties.Resources.UserId__DB_name, typeof(long));
                 CHECK__SignIn(login, password, obj);

         



                 if (obj.Value is DBNull) throw new InvalidAuthorize();

                 if (Convert.ToInt32(obj.Value) >= 1)
                 {
                     loadTotalInfo(obj);

                     userId = Convert.ToInt32(obj.Value);
                     Application.Current.MainWindow.Hide();
                     UserBanking userBanking = new UserBanking(this);
                 
                     userBanking.Show();
                     Application.Current.MainWindow.Close();
                   
                 }
                
             }
             catch (Exception ex)
             {
                 MessageBox.Show(ex.Message + ex.InnerException);
             }
             

         });

        private void loadTotalInfo(System.Data.Entity.Core.Objects.ObjectParameter objectParameter)
        {
            loadCurrentCards(objectParameter);
            if (cards.Count >0 && currentCard == null)
                CurrentCard = cards[0];

            loadAlerts(objectParameter);
       
            GC.Collect();
        }
        private void loadAlerts(System.Data.Entity.Core.Objects.ObjectParameter objectParameter)
        {
            foreach(var item in GET_AllAlerts(Convert.ToInt32(objectParameter.Value), this.Login, this.Password))
            {
                Alters.Add(item);
            }
        }
        private void loadCurrentCards(System.Data.Entity.Core.Objects.ObjectParameter objectParameter)
        {

            foreach (var item in GET_AllUsersCards(Convert.ToInt32(objectParameter.Value), Login, Password))
            {
                var cardPrivateValues = GET_PrivateCardInfo(item.Id_Card, Login, Password).FirstOrDefault();

                cards.Add(new Card(item, cardPrivateValues)
                {
                    GET_CardBalance_Result = GET_CardBalance(item.CardBalance_Id, this.login, this.password).FirstOrDefault(),
                    PaymentCompany = GET_PaymentCompany(item.PaymentCompany_Id).FirstOrDefault(),
                    CardLimit = GET_CardLimits(item.CardLimits_Id, this.login, this.password).FirstOrDefault(),
                    Type = Get__CardType(item.CardType_Id).FirstOrDefault(),
                    State= GET_CardState(item.CardState_Id).FirstOrDefault(),
                   

                }) ;
                foreach(var transactions in GET_AllTransactions(item.Id_Card, this.login, this.password))
                {
                    if(transactions != null)
                    cards[cards.Count - 1].Transctions.Add(transactions);
                  
                }
               
            }
   
        }
    }
}
