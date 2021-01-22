package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class team_BbsDAO{

        private Connection conn; // connection:db에접근하게 해주는 객체
		//private PreparedStatement pstmt;
		private ResultSet rs;


		// mysql 처리부분

		public team_BbsDAO() {

			// 생성자를 만들어준다.

			try {
				String dbURL = "jdbc:mysql://localhost:3306/board_db?&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				String dbID = "root";
				String dbPassword = "DevelopJSG1!";
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
    
    public String getDate() { 

			String SQL = "SELECT NOW()";

			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return ""; //데이터베이스 오류
		}
    
		//실제로 글을 작성하는 함수
		public int write(String AVGtier, String name, String top, String jungle, String mid, String bot, String support, String content, String password) { 
               
			String SQL = "INSERT INTO team VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, AVGtier);
				pstmt.setString(2, name);
				pstmt.setString(3, top);
                pstmt.setString(4, jungle);
                pstmt.setString(5, mid);
				pstmt.setString(6, bot);
                pstmt.setString(7, support);
                pstmt.setString(8, content);
				pstmt.setInt(9, 1);
                pstmt.setString(10,getDate());
                pstmt.setString(11,password);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
    
    public ArrayList<team_bbs> getList(int pageNumber){ 
				String SQL = "SELECT * FROM team  WHERE bbsAvailable = 1";
				ArrayList<team_bbs> list = new ArrayList<team_bbs>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						team_bbs team_bbs = new team_bbs();
						team_bbs.setAVGtier(rs.getString(1));
                        team_bbs.settop(rs.getString(3));
                        team_bbs.setjungle(rs.getString(4));
                        team_bbs.setmid(rs.getString(5));
                        team_bbs.setbot(rs.getString(6));
                        team_bbs.setsupport(rs.getString(7));
						team_bbs.setname(rs.getString(2));
                        team_bbs.setcontent(rs.getString(8));
						list.add(team_bbs);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
    
    public team_bbs getBbs(String name){
        String SQL = "SELECT * FROM team where name = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
            if(rs.next()){
                team_bbs team_bbs = new team_bbs();
				team_bbs.setAVGtier(rs.getString(1));
                team_bbs.setname(rs.getString(2));
				team_bbs.settop(rs.getString(3));
                team_bbs.setjungle(rs.getString(4));
                team_bbs.setmid(rs.getString(5));
                team_bbs.setbot(rs.getString(6));
                team_bbs.setsupport(rs.getString(7));
                team_bbs.setcontent(rs.getString(8));
                return team_bbs;
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    
    public int update(String AVGtier, String top, String jungle, String mid, String bot, String support, String content, String name) { 
               
			String SQL = "UPDATE team SET AVGtier = ?, top = ?, jungle = ?, mid = ?, bot = ?, support = ?, content = ?, time = ? WHERE name = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, AVGtier);
				pstmt.setString(2, top);
                pstmt.setString(3, jungle);
				pstmt.setString(4, mid);
                pstmt.setString(5, bot);
                pstmt.setString(6, support);
                pstmt.setString(7, content);
                pstmt.setString(8, getDate());
                pstmt.setString(9, name);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
    
    
    //삭제 함수
	public int delete(String name) {
		String SQL = "UPDATE team SET bbsAvailable = 0 WHERE name = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);   
			pstmt.setString(1, name);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
    
    public String callPassword(String name){
        String SQL = "SELECT password FROM team WHERE name = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    
}