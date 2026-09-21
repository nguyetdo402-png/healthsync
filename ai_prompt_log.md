# NHẬT KÝ SỬ DỤNG AI (AI PROMPT LOG)
**Dự án:** Tái cấu trúc CSDL HealthSync

---

### Prompt 1: Tìm hiểu về Anti-pattern trong thiết kế trạng thái
* **Nội dung Prompt:** "Trong thiết kế cơ sở dữ liệu quan hệ, tại sao việc dùng một cột is_active (kiểu TINYINT/BOOLEAN) để theo dõi vòng đời của một Đơn hàng/Lịch hẹn lại là một thiết kế tồi (Anti-pattern)? Tôi nên thay thế bằng cấu trúc nào?"
* **Mục đích:** Hiểu rõ lý do không dùng Boolean cho luồng nghiệp vụ đa trạng thái và lựa chọn kiểu `ENUM` / `VARCHAR` phù hợp.

### Prompt 2: Chọn kiểu dữ liệu tài chính chuẩn xác
* **Nội dung Prompt:** "Khi thiết kế cột deposit_amount và penalty_fee trong MySQL phục vụ tính toán tài chính, tôi nên dùng kiểu dữ liệu FLOAT, DOUBLE hay DECIMAL? Tại sao?"
* **Mục đích:** Tránh lỗi sai số làm tròn (float precision error) trong tính toán tài chính kế toán bằng cách sử dụng `DECIMAL(10,2)`.

### Prompt 3: Cú pháp chỉnh sửa và thêm khóa ngoại
* **Nội dung Prompt:** "Hãy cho tôi xem cú pháp chuẩn trong MySQL để tạo một bảng Prescriptions có khóa ngoại appointment_id liên kết 1-1 với bảng Appointments và hỗ trợ tự động xóa với ON DELETE CASCADE."
* **Mục đích:** Đảm bảo tính toàn vẹn dữ liệu và thiết lập đúng mối quan hệ giữa Lịch hẹn và Đơn thuốc.