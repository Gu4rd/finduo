package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class scream_BbsDAO{

        private Connection conn; // connection:db에접근하게 해주는 객체
		//private PreparedStatement pstmt;
		private ResultSet rs;


		// mysql 처리부분

		public scream_BbsDAO() {

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
		public int write(String AVGtier, String password, String name, String leadername, String content) { 
               
			String SQL = "INSERT INTO scream VALUES(?, ?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, AVGtier);
				pstmt.setString(2, name);
				pstmt.setString(3, leadername);
                pstmt.setString(4, content);
				pstmt.setInt(5, 1);
                pstmt.setString(6,getDate());
                pstmt.setString(7, password);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
    
    public ArrayList<scream_bbs> getList(int pageNumber){ 
				String SQL = "SELECT * FROM scream  WHERE bbsAvailable = 1";
				ArrayList<scream_bbs> list = new ArrayList<scream_bbs>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						scream_bbs scream_bbs = new scream_bbs();
						scream_bbs.setAVGtier(rs.getString(1));
                        scream_bbs.setleadername(rs.getString(3));
						scream_bbs.setname(rs.getString(2));
                        scream_bbs.setcontent(rs.getString(4));
						list.add(scream_bbs);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
    
    public scream_bbs getBbs(String name){
        String SQL = "SELECT * FROM scream where name = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if(rs.next()){
                scream_bbs scream_bbs = new scream_bbs();
				scream_bbs.setname(rs.getString(2));
                scream_bbs.setAVGtier(rs.getString(1));
				scream_bbs.setleadername(rs.getString(3));
                scream_bbs.setcontent(rs.getString(4));
                return scream_bbs;
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    
    //수정
    public int update(String AVGtier, String name, String content) { 
               
			String SQL = "UPDATE scream SET AVGtier = ?, content = ? WHERE name = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, AVGtier);
                pstmt.setString(2, content);
                pstmt.setString(3, name);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
    
        //삭제 함수
	public int delete(String name) {
		String SQL = "UPDATE scream SET bbsAvailable = 0 WHERE name = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);   
			pstmt.setString(1, name);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
    
    // 비밀번호 불러오기
    public String callPassword(String name){
        String SQL = "SELECT password FROM scream WHERE name = ?";
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