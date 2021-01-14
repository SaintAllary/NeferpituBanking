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
            if (cards.Count >0)
                CurrentCard = cards[0];
    
        }

        private void loadCurrentCards(System.Data.Entity.Core.Objects.ObjectParameter objectParameter)
        {

            foreach (var item in GET_AllUsersCards(Convert.ToInt32(objectParameter.Value), Login, Password))
            {
                var cardPrivateValues = GET_PrivateCardInfo(item.Id_Card, Login, Password).FirstOrDefault();

             
                //var cardPrivate = cardPrivateValues == null ? null : new CardPrivate(
                //                                                      cardPrivateValues.CVV_CardPrivate,
                //                                                      cardPrivateValues.ExpireDate_CardPrivate);
                cards.Add(new Card(item, cardPrivateValues));
               
            }
   
        }
    }
}
