package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
	// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리, 처리할때 사용

	private Connection conn;
	// DB 접근 객체

	private PreparedStatement pstmt;
	private ResultSet rs;
	// 정보를 담을 객체

	// Ctrl + Shift + O => "Organize Imports" = 클래스에 불필요한 import구문은 제거, 필요한 구문은 자동으로
	// 추가

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) // 로그인 처리하는 함수
	{
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // 실행 결과를 넣고,
			if (rs.next()) // 결과가 존재한다면
			{
				if (rs.getString(1).equals(userPassword))
				// 결과로 나온 userPassword를 받아서 접속을 시도한 userPassword와 동일하다면
				{
					return 1; // 로그인 성공
				} else
					return 0; // 로그인 실패(비밀번호 틀림)

			}
			return -1; // 아이디가 없음 userID=?부분 확인
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return -2; // 데이터베이스 오류
	}

	public int join(User user) {
		String SQL = "INSERT INTO user VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return -1;
	}

	public User myPage(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ? ";
		User user = new User();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return user;
	}
}
