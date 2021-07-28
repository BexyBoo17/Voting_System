



public class Result 
{
    private String minicipalityName;
    private String partyName;
    private int zVotes;
    
    //default constructor
    public Result()
    {
        
    }

    //parameterised constructor
    public Result(String minicipalityName, String partyName, int zVotes) {
        this.minicipalityName = minicipalityName;
        this.partyName = partyName;
        this.zVotes = zVotes;
    }
    
    //copy constructor
    public Result(Result r)
    {
        minicipalityName = r.getMinicipalityName();
        partyName = r.getPartyName();
        zVotes = r.getzVotes();
    }
    
    //getters and setters
    public String getMinicipalityName() {
        return minicipalityName;
    }

    public void setMinicipalityName(String minicipalityName) {
        this.minicipalityName = minicipalityName;
    }

    public String getPartyName() {
        return partyName;
    }

    public void setPartyName(String partyName) {
        this.partyName = partyName;
    }

    public int getzVotes() {
        return zVotes;
    }

    public void setzVotes(int zVotes) {
        this.zVotes = zVotes;
    }
    
    
}
