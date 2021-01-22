package notice;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.util.ArrayList;


public class noticeDAO {

		// dao : 데이터베이스 접근 객체의 약자
		private Connection conn; // connection:db에접근하게 해주는 객체
		//private PreparedStatement pstmt;
		private ResultSet rs;


		// mysql 처리부분

		public noticeDAO() {

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

            // 글 목록을 가져오는 함수
			public ArrayList<notice> getList(int pageNumber){ 
				String SQL = "SELECT * FROM notice ";
				ArrayList<notice> list = new ArrayList<notice>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						notice notice = new notice();
						notice.setnoticeName(rs.getString(1));
                        notice.setnoticeDate(rs.getString(2));
						notice.setnoticeContent(rs.getString(3));
						list.add(notice);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
}
