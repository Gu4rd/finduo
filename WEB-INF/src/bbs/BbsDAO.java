package bbs;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.util.ArrayList;


public class BbsDAO {

		// dao : 데이터베이스 접근 객체의 약자
		private Connection conn; // connection:db에접근하게 해주는 객체
		//private PreparedStatement pstmt;
		private ResultSet rs;


		// mysql 처리부분

		public BbsDAO() {

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

		
		//현재의 시간을 가져오는 함수

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

		//bbsID 게시글 번호 가져오는 함수

			public int getNext() { 
				String SQL = "SELECT number FROM boards ORDER BY number DESC";

				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getInt(1) + 1;
					}
					return 1;//첫 번째 게시물인 경우
				} catch (Exception e) {
					e.printStackTrace();
				}

				return -1; //데이터베이스 오류
            }
    		public int commentGetNext() { 
				String SQL = "SELECT number FROM comment ORDER BY number DESC";

				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getInt(1) + 1;
					}
					return 1;//첫 번째 댓글인 경우
				} catch (Exception e) {
					e.printStackTrace();
				}

				return -1; //데이터베이스 오류
            }
		
			//실제로 글을 작성하는 함수
			public int write(String bbsName, String userNickname, String userPassword, String bbsContent, String userIp) { 
                
				String SQL = "INSERT INTO boards VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setString(2, bbsName);
					pstmt.setString(3, userNickname);
                    pstmt.setString(4, userPassword);
                    pstmt.setString(5, bbsContent);
					pstmt.setString(6, getDate());
					pstmt.setInt(7, 1);
					pstmt.setString(8, userIp);
                    pstmt.setInt(9, 0);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; //데이터베이스 오류
			}
    
            // 글 목록을 가져오는 함수
			public ArrayList<bbs> getList(int pageNumber){ 
				String SQL = "SELECT * FROM boards WHERE available = 1 ORDER BY number DESC LIMIT 10 OFFSET ?";
				ArrayList<bbs> list = new ArrayList<bbs>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, (pageNumber -1) * 10);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						bbs bbs = new bbs();
						bbs.setBbsNumber(rs.getInt(1));
						bbs.setBbsName(rs.getString(2));
						bbs.setUserNickname(rs.getString(3));
						bbs.setUserPassword(rs.getString(4));
                        bbs.setBbsContent(rs.getString(5));
						bbs.setBbsDate(rs.getString(6));
						bbs.setBbsAvailable(rs.getInt(7));
                        bbs.setUserIp(rs.getString(8));
						list.add(bbs);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
    		public ArrayList<bbs> getSearchList(int pageNumber, String keyword){ 
				String SQL = "SELECT * FROM boards WHERE available = 1 AND name LIKE ? ORDER BY number DESC LIMIT 10 OFFSET ?";
				ArrayList<bbs> list = new ArrayList<bbs>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
                    System.out.println(keyword);
                    pstmt.setString(1, keyword);
					pstmt.setInt(2, (pageNumber -1) * 10);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						bbs bbs = new bbs();
						bbs.setBbsNumber(rs.getInt(1));
						bbs.setBbsName(rs.getString(2));
						bbs.setUserNickname(rs.getString(3));
						bbs.setUserPassword(rs.getString(4));
                        bbs.setBbsContent(rs.getString(5));
						bbs.setBbsDate(rs.getString(6));
						bbs.setBbsAvailable(rs.getInt(7));
                        bbs.setUserIp(rs.getString(8));
						list.add(bbs);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
    
	        // 페이징 처리를 위한 함수
			public boolean nextPage (int pageNumber) {
				String SQL = "SELECT * FROM boards WHERE available = 1 ORDER BY number DESC LIMIT 10 OFFSET ?";
				ArrayList<bbs> list = new ArrayList<bbs>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, (pageNumber -1) * 10);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						return true;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return false; 		
			}
        	public bbs getBbs(int number) {
		        String SQL = "SELECT * FROM boards WHERE number = ?";
		        try {
			        PreparedStatement pstmt = conn.prepareStatement(SQL);
			        pstmt.setInt(1, number);
			        rs = pstmt.executeQuery();
			        if (rs.next()) {
				        bbs bbs = new bbs();
				        bbs.setBbsNumber(rs.getInt(1));
				        bbs.setBbsName(rs.getString(2));
				        bbs.setUserNickname(rs.getString(3));
				        bbs.setUserPassword(rs.getString(4));
                        bbs.setBbsContent(rs.getString(5));
				        bbs.setBbsDate(rs.getString(6));
				        bbs.setBbsAvailable(rs.getInt(7));
                        bbs.setUserIp(rs.getString(8));
                        bbs.setCommentCount(rs.getInt(9));
				        return bbs;
			        }
		        } catch (Exception e) {
			        e.printStackTrace();
		        }
		        return null;
	        }
            public String callPassword(int number){
                String SQL = "SELECT password FROM boards WHERE number = ?";
                try{
                    PreparedStatement pstmt = conn.prepareStatement(SQL);
                    pstmt.setInt(1, number);
                    rs = pstmt.executeQuery();
                    if(rs.next()){
                        return rs.getString(1);
                    }
                }catch(Exception e){
                    e.printStackTrace();
                }
                return null;
            }
    
	        //수정 함수
	        public int update(int number, String bbsName, String bbsContent) {
			    String SQL = "UPDATE boards SET name = ?, content = ? WHERE number = ?";
			    try {
				    PreparedStatement pstmt = conn.prepareStatement(SQL);
				    pstmt.setString(1, bbsName);
				    pstmt.setString(2, bbsContent);
				    pstmt.setInt(3, number);
				    return pstmt.executeUpdate();
			    } catch (Exception e) {
				    e.printStackTrace();
			    }
			    return -1; // 데이터베이스 오류
		    }
    
    	    //삭제 함수
	        public int delete(int number) {
		        String SQL = "UPDATE boards SET available = 0 WHERE number = ?";
		        try {
			        PreparedStatement pstmt = conn.prepareStatement(SQL);   
			        pstmt.setInt(1, number);
			        return pstmt.executeUpdate();
		        } catch (Exception e) {
			        e.printStackTrace();
		        }
		        return -1; // 데이터베이스 오류
	        }
            
            // 댓글 목록
            public ArrayList<CommentDto> getCommentList(int boardNumber){
                ArrayList<CommentDto> list = new ArrayList<CommentDto>();
                String SQL = "SELECT * FROM comment WHERE boardNumber = ?";
                try{
                    PreparedStatement pstmt = conn.prepareStatement(SQL);
                    pstmt.setInt(1, boardNumber);
                    rs = pstmt.executeQuery();
                    while(rs.next()){
                        CommentDto comment = new CommentDto();
                        comment.setCommentNumber(rs.getInt(1));
                        comment.setBoardNumber(rs.getInt(2));
                        comment.setId(rs.getString(3));
                        comment.setPassword(rs.getString(4));
                        comment.setCommentDate(rs.getString(5));
                        comment.setCommentContent(rs.getString(6));
                        list.add(comment);
                    }
                }
                catch(Exception e){
                    e.printStackTrace();
                }
                return list;
            }
    
            // 댓글 저장
            public int insertComment(String id, String password, String commentContent, int boardNumber){
                String SQL = "INSERT INTO comment VALUES(?, ?, ?, ?, ?, ?)";
                try{
                    PreparedStatement pstmt = conn.prepareStatement(SQL);
                    pstmt.setInt(1, commentGetNext());
                    pstmt.setInt(2, boardNumber);
                    pstmt.setString(3, id);
                    pstmt.setString(4, password);
                    pstmt.setString(5, getDate());
                    pstmt.setString(6, commentContent);
                    return pstmt.executeUpdate();
                } catch(Exception e){
                    e.printStackTrace();
                }
                return -1;
            }
    
            // 댓글 삭제
            public int deleteComment(int number){
                String SQL = "DELETE FROM comment WHERE number = ?";
                try{
                    PreparedStatement pstmt = conn.prepareStatement(SQL);
                    pstmt.setInt(1, number);
                    return pstmt.executeUpdate();
                } catch(Exception e){
                    e.printStackTrace();
                }
                return -1;
            }
            // 댓글 비밀번호 불러오기
            public String callCommentPassword(int number){
                String SQL = "SELECT password FROM comment WHERE number = ?";
                try{
                    PreparedStatement pstmt = conn.prepareStatement(SQL);
                    pstmt.setInt(1, number);
                    rs = pstmt.executeQuery();
                    if(rs.next()){
                        return rs.getString(1);
                    }
                }catch(Exception e){
                    e.printStackTrace();
                }
                return null;
            }
            public int countComments(int boardNumber){
                String SQL = "SELECT count(*) FROM comment WHERE boardNumber = ?";
                try{
                    PreparedStatement pstmt = conn.prepareStatement(SQL);
                    pstmt.setInt(1, boardNumber);
                    rs = pstmt.executeQuery();
                    if(rs.next()){
                        return rs.getInt(1);
                    }
                } catch(Exception e){
                    e.printStackTrace();
                }
                return 0;
            }

}
