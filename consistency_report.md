# BÁO CÁO PHÂN TÍCH LỖ HỔNG DỮ LIỆU (GAP ANALYSIS REPORT)
**Dự án:** Hệ thống Quản lý Phòng khám HealthSync

---

### 3 Điểm Vênh Nghiêm Trọng Giữa Nghiệp Vụ (UML) và Thiết Kế Cũ (Legacy DB)

1. **Sai lệch trong việc biểu diễn Vòng đời Lịch hẹn (Lifecycle Status):**
   * *Nghiệp vụ (UML):* Yêu cầu theo dõi lịch hẹn qua 5 trạng thái rõ ràng: `PENDING` -> `CONFIRMED` -> `CHECKED_IN` -> `COMPLETED` / `CANCELLED`.
   * *Thiết kế cũ:* Sử dụng cột `is_active BOOLEAN`. Kiểu `BOOLEAN` chỉ đại diện được 2 trạng thái (`TRUE`/`FALSE`), hoàn toàn bất lực trong việc nhận biết lịch hẹn đang ở bước nào trong quy trình.

2. **Thiếu hoàn toàn các trường dữ liệu Tài chính và Quản lý Hủy lịch:**
   * *Nghiệp vụ (UML):* Quy định rõ bệnh nhân phải đóng tiền cọc (`deposit_amount`), nếu hủy lịch sẽ bị tính phí phạt (`penalty_fee`) và phải lưu lý do hủy (`cancel_reason`).
   * *Thiết kế cũ:* Không có bất kỳ cột nào lưu trữ tài chính hay lý do hủy. Điều này dẫn đến thất thoát tiền cọc và làm cho công tác kế toán/đối soát doanh thu bị sai lệch hoàn toàn.

3. **Thiếu Bảng Đơn thuốc (`Prescriptions`) - Đứt gãy luồng Khám bệnh:**
   * *Nghiệp vụ (UML):* Sau khi khám xong (`COMPLETED`), Bác sĩ phải kê đơn thuốc đi kèm với lịch hẹn đó.
   * *Thiết kế cũ:* Hoàn toàn không có bảng hay trường dữ liệu nào để lưu trữ đơn thuốc, khiến chức năng cốt lõi của phòng khám không thể vận hành trên hệ thống.