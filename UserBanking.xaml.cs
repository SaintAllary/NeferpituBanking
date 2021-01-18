using GalaSoft.MvvmLight.CommandWpf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace NeferpituBanking
{
    /// <summary>
    /// Interaction logic for UserBanking.xaml
    /// </summary>
    public partial class UserBanking : Window
    {
        public UserBanking()
        {
            InitializeComponent();
        }

        public UserBanking(ViewModel viewModel)
        {
    
            InitializeComponent();
            DataContext = viewModel;

            //MessageBox.Show((DataContext as ViewModel).CurrentCard.Code);
        }



        private void OnCloseExecuted(object sender, ExecutedRoutedEventArgs e)
        {
            this.Close();
        }

        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {

            if(e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }
        }


        private void minimize(object sender, RoutedEventArgs e)
        {
            this.WindowState = WindowState.Minimized;
        }

        private void mini(object sender, RoutedEventArgs e)
        {
            this.WindowState = WindowState.Normal;
            this.Width = this.MinWidth;
            this.Height = this.MinHeight;
        }
    }
}
