using GalaSoft.MvvmLight.Command;
using NeferpituBanking.Exceptions;
using NeferpituBanking.Tables_Classes;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data.Entity.Core.Objects;
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

        private string newPassword;
        public string NewPassword { get => newPassword;
            set
            {
                newPassword = value;
                OnPropertyChanged(nameof(newPassword));
            }
        }

        private string oldPassword;
        public string OldPassword
        {
            get => oldPassword;
            set
            {
                oldPassword = value;
                OnPropertyChanged(nameof(oldPassword));
            }
        }



        private ObservableCollection<GET_AllAlerts_Result> alters;
        public ObservableCollection<GET_AllAlerts_Result> Alters {
            get => alters;
            set
            {
                alters = value;
                OnPropertyChanged(nameof(Alters));
            }
        }

        private GET_AccountInfo_Result userInfo { get; set; }
        public GET_AccountInfo_Result UserInfo { 
            get => userInfo;

            set
            {
               
                userInfo = value;
                OnPropertyChanged(nameof(UserInfo));
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
                OnPropertyChanged(nameof(Password));
            }
        }

        private string login;
        public string Login
        {
            get => login;
            set
            {
                login = value;
                OnPropertyChanged(nameof(Login));
            }
        }

        private ObservableCollection<Card> cards;

        public ObservableCollection<Card> Cards
        {
            get => cards; set
            {
                cards = value;
                OnPropertyChanged(nameof(Cards));
            }
        }


        private Card currentCard;
        public Card CurrentCard
        {
            get => currentCard;
            set
            {
                currentCard = value;
                OnPropertyChanged(nameof(CurrentCard));
            }
        }

        private Nullable<long> destinationCard;
        public Nullable<long> DestinationCard
        {
            get => destinationCard; 
            set
            {
                destinationCard = value;
                OnPropertyChanged(nameof(DestinationCard));
            }
        }


        public Nullable<decimal> moneyValue { get; set; }
        public Nullable<decimal> MoneyValue
        {
            get => moneyValue;
            set {
                moneyValue = value;
                OnPropertyChanged(nameof(MoneyValue));
            }
        }

        public ViewModel()
        {
            Cards = new ObservableCollection<Card>();
            Alters = new ObservableCollection<GET_AllAlerts_Result>();
            DestinationCard = null;
            MoneyValue = null;
            NewPassword = null;
            OldPassword = null;

        }
        public ICommand SendMoney => new RelayCommand(() =>
        {
            try
            {
             
                var valuw =  DO__Transaction(this.MoneyValue, this.CurrentCard.Id_Card, this.DestinationCard.ToString());
               

                if (valuw<0)
                {
                    throw new InvalidOperation();
                }
                else
                {
                    clearAllValues();
                    loadTotalInfo(this.UserIdObj);

                }
                
        
        


            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        });

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged([CallerMemberName] string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }

        private ObjectParameter userIdObj;
        private ObjectParameter UserIdObj { get => userIdObj;
            set
            {
                userIdObj = value;
                OnPropertyChanged(nameof(userIdObj));

            }
        }

        public ICommand UserSignIn => new RelayCommand(() =>
         {
           
             try
             {
                 UserIdObj = new ObjectParameter(Properties.Resources.UserId__DB_name, typeof(long));
                 CHECK__SignIn(login, password, UserIdObj);

         



                 if (UserIdObj.Value is DBNull) throw new InvalidAuthorize();

                 if (Convert.ToInt32(UserIdObj.Value) >= 1)
                 {
                     loadTotalInfo(UserIdObj);

                     userId = Convert.ToInt32(UserIdObj.Value);
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

        public ICommand ChangePass => new RelayCommand(() =>
        {
            try
            {
               if (this.OldPassword == this.Password)
               {
                    SET_Password(this.NewPassword, this.Login, this.Password, Convert.ToInt32(this.userIdObj.Value));
                    this.OldPassword = null;
                    this.Password = NewPassword;
                    this.NewPassword = null;
                    MessageBox.Show("Succesess!");
               }
               else
                {
                    throw new InvalidOperation();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        });

        private void loadTotalInfo(ObjectParameter objectParameter)
        {
            loadCurrentCards(objectParameter);
            
           
            CurrentCard = cards.FirstOrDefault();

            loadAlerts(objectParameter);
            loadAccountInfo(objectParameter);
            GC.Collect();
        }
        private void loadAlerts(ObjectParameter objectParameter)
        {
            foreach(var item in GET_AllAlerts(Convert.ToInt32(objectParameter.Value), this.Login, this.Password))
            {
                Alters.Add(item);
            }
        }
        private void loadCurrentCards(ObjectParameter objectParameter)
        {

            foreach (var item in GET_AllUsersCards(Convert.ToInt32(objectParameter.Value), Login, Password))
            {
                var cardPrivateValues = GET_PrivateCardInfo(item.Id_Card, Login, Password).FirstOrDefault();

                Cards.Add(new Card(item, cardPrivateValues)
                {
                    GET_CardBalance_Result = GET_CardBalance(item.CardBalance_Id, this.login, this.password).FirstOrDefault(),
                    PaymentCompany = GET_PaymentCompany(item.PaymentCompany_Id).FirstOrDefault(),
                    CardLimit = GET_CardLimits(item.CardLimits_Id, this.Login, this.Password).FirstOrDefault(),
                    Type = Get__CardType(item.CardType_Id).FirstOrDefault(),
                    State= GET_CardState(item.CardState_Id).FirstOrDefault(),
                   

                }) ;
                foreach(var transactions in GET_AllTransactions(item.Id_Card, this.Login, this.Password).Reverse())
                {
                    if(transactions != null)
                    Cards[Cards.Count - 1].Transctions.Add(transactions);
                  
                }
               
            }
   
        }

        private void loadAccountInfo(ObjectParameter objectParameter)
        {
            UserInfo = GET_AccountInfo(Convert.ToInt32(objectParameter.Value), this.Login,this.Password).FirstOrDefault();
        }

        private void clearAllValues()
        {

            Cards = new ObservableCollection<Card>();
            Alters = new ObservableCollection<GET_AllAlerts_Result>();
            DestinationCard = null;
            MoneyValue = null;

        }
        private async void loadtotalAsync(ObjectParameter objectParameter)
        {
           
             await new Task(() => this.loadTotalInfo(objectParameter));
        }
    }
}
