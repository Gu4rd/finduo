package bbs;

public class CommentDto {
    
    private int number;
    private String id;
    private String password;
    private String commentContent;
    private String commentDate;
    private int boardNumber;
    
    public int getCommentNumber() {
        return number;
    }
    public void setCommentNumber(int number) {
        this.number = number;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getCommentContent() {
        return commentContent;
    }
    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }
    public String getCommentDate() {
        return commentDate;
    }
    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }
    public int getBoardNumber() {
        return boardNumber;
    }
    public void setBoardNumber(int boardNumber) {
        this.boardNumber = boardNumber;
    }
    
    @Override
    public String toString() {
        return "CommentDto [commentNumber=" + number + ", id=" + id + ", password=" + password +", commentContent=" + commentContent
                + ", commentDate=" + commentDate + ", boardNumber=" + boardNumber + "]";
    }

}
