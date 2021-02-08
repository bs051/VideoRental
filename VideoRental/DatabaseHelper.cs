using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VideoRental
{
    
    public class DatabaseHelper // Class for database CRUD operations
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["VideoRentalConnString"].ConnectionString);
        // add customer method
        public void AddCustomer(string FirstName, string Lastname, string Address, string Mobile)
        {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("insert into Customer(FirstName,LastName,Address,Phone)values(@FirstName,@LastName,@Address,@Phone)", conn))
                {
                    cmd.Parameters.AddWithValue("@FirstName", FirstName);
                    cmd.Parameters.AddWithValue("@LastName", Lastname);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Phone", Mobile);

                    cmd.ExecuteNonQuery();

                }
                conn.Close();
                
        }
        // edit customer method
        public void EditCustomer(int id,string FirstName, string Lastname, string Address, string MobileNo)
        {

                conn.Open();
                using (SqlCommand cmd = new SqlCommand("update Customer set FirstName=@FirstName,LastName=@LastName,Address=@Address,Phone=@Phone  where CustId=@CustId", conn))
                {
                cmd.Parameters.AddWithValue("@CustId", id);
                cmd.Parameters.AddWithValue("@FirstName", FirstName);
                    cmd.Parameters.AddWithValue("@LastName", Lastname);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Phone", MobileNo);
                   
                    cmd.ExecuteNonQuery();

                }
                conn.Close();
               
        }

        // delete customer method
        public void DeleteCustomer(int CustomerId)
        {

                conn.Open();
                using (SqlCommand cmd = new SqlCommand("delete from Customer where CustId=@CustId", conn))
                {
                cmd.Parameters.AddWithValue("@CustId", CustomerId);
                    cmd.ExecuteNonQuery();

                }
                conn.Close();
               
        }
        // add video method
        public void AddVideo(string VideoName, DateTime ReleaseDate, decimal Cost, string Genre, string Plot)
        {

            
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("insert into Movie(Title,ReleaseDate,RentalCost,Genre,Plot)values(@Title,@ReleaseDate,@RentalCost,@Genre,@Plot)", conn))
                {
                    cmd.Parameters.AddWithValue("@Title", VideoName);
                    cmd.Parameters.AddWithValue("@ReleaseDate", ReleaseDate);
                    cmd.Parameters.AddWithValue("@RentalCost", Cost);
                    cmd.Parameters.AddWithValue("@Genre", Genre);
                    cmd.Parameters.AddWithValue("@Plot", Plot);
                    cmd.ExecuteNonQuery();

                }
                conn.Close();
                
        }
        // edit video method
        public void EditVideo(int VideoId,string VideoName, DateTime ReleaseDate, decimal Cost, string Genre, string Plot)
        {

           
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("update Movie set Title=@Title,ReleaseDate=@ReleaseDate,RentalCost=@RentalCost,Genre=@Genre,Plot=@Plot where MovieId=@MovieId", conn))
                {
                    cmd.Parameters.AddWithValue("@MovieId", VideoId);
                    cmd.Parameters.AddWithValue("@Title", VideoName);
                    cmd.Parameters.AddWithValue("@ReleaseDate", ReleaseDate);
                    cmd.Parameters.AddWithValue("@RentalCost", Cost);
                    cmd.Parameters.AddWithValue("@Genre", Genre);
                    cmd.Parameters.AddWithValue("@Plot", Plot);
                    cmd.ExecuteNonQuery();

                }
                conn.Close();
               
        }
        // delete video method
        public void DeleteVideo(int id)
        {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("delete from Movie where MovieId=@MovieId", conn))
                {
                    cmd.Parameters.AddWithValue("@MovieId", id);

                    cmd.ExecuteNonQuery();

                }
                conn.Close();
              
        }
        // add rented video method
        public void AddRentalVideo(int VideoId, int CustomerId)
        {

                conn.Open();
                using (SqlCommand cmd = new SqlCommand("insert into RentedMovies(MovieId,CustId,DateRented)values(@MovieId,@CustId,@DateRented)", conn))
                {
                    cmd.Parameters.AddWithValue("@MovieId", VideoId);
                    cmd.Parameters.AddWithValue("@CustId", CustomerId);
                    cmd.Parameters.AddWithValue("@DateRented", DateTime.Now);

                    cmd.ExecuteNonQuery();

                }
                conn.Close();
                
        }
        // return video method
        public void Returned(int ReturnId)
        {

                conn.Open();
                using (SqlCommand cmd = new SqlCommand("update RentedMovies set DateReturned=@DateReturned where RentedMovieId=@RentedMovieId", conn))
                {
                    cmd.Parameters.AddWithValue("@RentedMovieId", ReturnId);
                    cmd.Parameters.AddWithValue("@DateReturned", DateTime.Now);

                    cmd.ExecuteNonQuery();

                }
                conn.Close();
               
        }
    }
}
