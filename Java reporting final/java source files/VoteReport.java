


//imports
import java.sql.*;
import java.beans.XMLEncoder;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;


public class VoteReport {

    
    public static void main(String[] args) 
    {
        
        
        //result list for the different types municipalities
        List<Result> lowerResults = new ArrayList<>();
        List<Result> upperResults = new ArrayList<>();
        
        try{  
            
                        //establish connection
			Class.forName("com.mysql.jdbc.Driver");  
                        //database details, change password and username
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/voting_system?characterEncoding=latin1&useConfigs=maxPerformance","root","IDKwhatName123");  
			Statement stmt=con.createStatement();
                        
                        //first sql statement
			ResultSet rs=stmt.executeQuery("SELECT local_municipality.name, party.name, COUNT(vote_local_municipality.vote_id) " +
                                                        "FROM vote_local_municipality " +
                                                        "INNER JOIN local_municipality ON vote_local_municipality.local_muni_id = local_municipality.local_muni_id " +
                                                        "INNER JOIN party ON vote_local_municipality.party_id = party.party_id " +
                                                        "GROUP BY local_municipality.name, party.name " +
                                                        "ORDER BY local_municipality.local_muni_id,COUNT(vote_local_municipality.vote_id) DESC;");
                        
                        //extract data from resultSet to lowerResults
                        System.out.println("Local municipality results:");
                        while(rs.next())
                        {
                            System.out.println(rs.getString(1) + ": party - " + rs.getString(2)+" - total votes: "+rs.getInt(3));
                            lowerResults.add(new Result(rs.getString(1),rs.getString(2),rs.getInt(3)));
                        }
                        ResultList lower = new ResultList();
                        lower.setResults(lowerResults);
                        //second sql statement
			rs=stmt.executeQuery("SELECT upper_municipality.name, party.name, COUNT(vote_upper_municipality.vote_id) " +
                        "FROM vote_upper_municipality " +
                        "INNER JOIN upper_municipality ON vote_upper_municipality.upper_municipality_upper_muni_id = upper_municipality.upper_muni_id " +
                        "INNER JOIN party ON vote_upper_municipality.party_party_id = party.party_id " +
                        "GROUP BY upper_municipality.name, party.name " +
                        "ORDER BY upper_municipality.upper_muni_id,COUNT(vote_upper_municipality.vote_id) DESC;");
                        
                        //extract data from resultSet to upperResults
                        System.out.println("Upper municipality results:");
                        while(rs.next())
                        {
                            System.out.println(rs.getString(1) + ": party - " + rs.getString(2)+" total votes: "+rs.getInt(3));
                            upperResults.add(new Result(rs.getString(1),rs.getString(2),rs.getInt(3)));
                        }
                        ResultList upper = new ResultList();
                        upper.setResults(upperResults);
                        
                        //close connection
			con.close();
                        
                        //convert object data to xml
                        try
                        {
                            //store in xml file named local_results.xml
                            FileOutputStream f = new FileOutputStream(new File("local_results.xml"));
                            XMLEncoder encoder = new XMLEncoder(f);
                            encoder.writeObject(lower);
                            encoder.close();
                            
                        }
                        catch(IOException ex)
                        {
                            
                        }
                        
                        //convert object data to xml
                        try
                        {
                            //store in xml file named upper_results.xml
                            FileOutputStream f = new FileOutputStream(new File("upper_results.xml"));
                            XMLEncoder encoder = new XMLEncoder(f);
                            encoder.writeObject(upper);
                            encoder.close();
                            
                        }
                        catch(IOException ex)
                        {
                            
                        }
		}
        
        
        
		catch(Exception e){ 
			System.out.println(e);
		} 
    }
    
}
