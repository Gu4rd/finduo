package bbs;

public class duo_bbs {

	private String nickname;
    private String password;
	private String me_tier;
	private String me_line;
    private String you_tier;
	private String you_line;
    private String content;
    private int bbsAvailable;

	
	public String getnickname() {

		return nickname;

	}

	public void setnickname(String nickname) {

		this.nickname = nickname;

	}
    
    public String getpassword() {

		return password;

	}

	public void setpassword(String password) {

		this.password = password;

	}

	public String getme_tier() {

		return me_tier;

	}

	public void setme_tier(String me_tier) {

		this.me_tier = me_tier;

	}
    
    public String getme_line() {
        
        return me_line;
        
    }
    
    public void setme_line(String me_line) {
        
        this.me_line = me_line;
        
    }
    public String getyou_tier() {

		return you_tier;

	}

	public void setyou_tier(String you_tier) {

		this.you_tier = you_tier;

	}

	public String getyou_line() {

		return you_line;

	}

	public void setyou_line(String you_line) {

		this.you_line = you_line;

	}
    
    public String getcontent() {
        
        return content;
        
    }
    
    public void setcontent(String content) {
        
        this.content = content;
        
    }

	public int getBbsAvailable() {

		return bbsAvailable;

	}

	public void setBbsAvailable(int bbsAvailable) {

		this.bbsAvailable = bbsAvailable;

	}    
}