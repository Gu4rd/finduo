package bbs;

public class bbs {

	private int bbsNumber;
	private String bbsName;
	private String userNickname;
    private String userPassword;
	private String bbsDate;
    private String userIp;
    private String bbsContent;
	private int bbsAvailable;
    private int commentCount;

	public int getBbsNumber() {

		return bbsNumber;

	}

	public void setBbsNumber(int bbsNumber) {

		this.bbsNumber = bbsNumber;

	}

	public String getBbsName() {

		return bbsName;

	}

	public void setBbsName(String bbsName) {

		this.bbsName = bbsName;

	}

	public String getUserNickname() {

		return userNickname;

	}

	public void setUserNickname(String userNickname) {

		this.userNickname = userNickname;

	}
    
    public String getUserPassword() {
        
        return userPassword;
        
    }
    
    public void setUserPassword(String userPassword) {
        
        this.userPassword = userPassword;
        
    }
    public String getBbsContent() {

		return bbsContent;

	}

	public void setBbsContent(String bbsContent) {

		this.bbsContent = bbsContent;

	}

	public String getBbsDate() {

		return bbsDate;

	}

	public void setBbsDate(String bbsDate) {

		this.bbsDate = bbsDate;

	}
    
    public String getUserIp() {
        
        return userIp;
        
    }
    
    public void setUserIp(String userIp) {
        
        this.userIp = userIp;
        
    }

	public int getBbsAvailable() {

		return bbsAvailable;

	}

	public void setBbsAvailable(int bbsAvailable) {

		this.bbsAvailable = bbsAvailable;

	}
    public int getCommentCount() {
        return commentCount;
    }
    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }


}
