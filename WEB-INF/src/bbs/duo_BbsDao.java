package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class duo_BbsDao{

        private Connection conn; // connection:db에접근하게 해주는 객체
		//private PreparedStatement pstmt;
		private ResultSet rs;


		// mysql 처리부분

		public duo_BbsDao() {

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
		public int write(String nickname, String password, String me_tier, String me_line, String you_tier, String you_line, String content) { 
               
			String SQL = "INSERT INTO duo_board VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, nickname);
                pstmt.setString(2, password);
				pstmt.setString(3, me_tier);
				pstmt.setString(4, me_line);
                pstmt.setString(5, you_tier);
                pstmt.setString(6, you_line);
				pstmt.setString(7, content);
				pstmt.setInt(8, 1);
                pstmt.setString(9,getDate());
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
    
    public ArrayList<duo_bbs> getList(int pageNumber){ 
				String SQL = "SELECT * FROM duo_board  WHERE bbsAvailable = 1";
				ArrayList<duo_bbs> list = new ArrayList<duo_bbs>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						duo_bbs duo_bbs = new duo_bbs();
						duo_bbs.setnickname(rs.getString(1));
                        duo_bbs.setme_tier(rs.getString(3));
						duo_bbs.setme_line(rs.getString(4));
                        duo_bbs.setyou_line(rs.getString(6));
                        duo_bbs.setcontent(rs.getString(7));
						list.add(duo_bbs);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
    
    //update 함수
    public int update(String me_tier, String me_line, String you_line, String content, String nickname) { 
               
			String SQL = "UPDATE duo_board SET me_tier = ?, me_line = ?, you_line = ?, content = ?, time = ? WHERE nickname = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, me_tier);
				pstmt.setString(2, me_line);
                pstmt.setString(3, you_line);
				pstmt.setString(4, content);
                pstmt.setString(5, getDate());
                pstmt.setString(6, nickname);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
    
    public duo_bbs getBbs(String nickname){
        String SQL = "SELECT * FROM duo_board where nickname = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,nickname);
            rs = pstmt.executeQuery();
            if(rs.next()){
                duo_bbs duo_bbs = new duo_bbs();
				duo_bbs.setnickname(rs.getString(1));
                duo_bbs.setme_tier(rs.getString(3));
				duo_bbs.setme_line(rs.getString(4));
                duo_bbs.setyou_line(rs.getString(6));
                duo_bbs.setcontent(rs.getString(7));
                return duo_bbs;
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    //삭제 함수
	public int delete(String name) {
		String SQL = "UPDATE duo_board SET bbsAvailable = 0 WHERE nickname = ?";
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
        String SQL = "SELECT password FROM duo_board WHERE nickname = ?";
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