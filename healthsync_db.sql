-- 1. TẠO CƠ SỞ DỮ LIỆU VÀ SỬ DỤNG
CREATE DATABASE IF NOT EXISTS healthsync_db;
USE healthsync_db;

-- 2. TẠO BẢNG PATIENTS
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

-- 3. TẠO BẢNG DOCTORS
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)
);

-- 4. TẠO BẢNG APPOINTMENTS (Cấu trúc tối ưu hóa)
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    deposit_amount DECIMAL(10, 2) DEFAULT 0.00,
    penalty_fee DECIMAL(10, 2) DEFAULT 0.00,
    cancel_reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 5. TẠO BẢNG PRESCRIPTIONS (Tạo mới)
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    medication_details TEXT NOT NULL,
    issued_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- ========================================================
-- VẬN HÀNH VÀ KỊCH BẢN MÔ PHỎNG DỮ LIỆU (DML)
-- ========================================================

-- Thêm dữ liệu mẫu
INSERT INTO Patients (full_name, phone) VALUES 
('Nguyen Van A', '0901234567'),
('Tran Thi B', '0987654321');

INSERT INTO Doctors (full_name, specialty) VALUES 
('BS. Le Van C', 'Noi khoa'),
('BS. Pham Thi D', 'Nhi khoa');

-- Kịch bản 1: Khám bệnh thành công
-- Step 1: Bệnh nhân A đặt lịch
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (1, 1, '2026-10-01 09:00:00', 'PENDING', 500000.00);

-- Step 2: Bệnh nhân checked-in
UPDATE Appointments SET status = 'CHECKED_IN' WHERE appointment_id = 1;

-- Step 3: Hoàn tất khám
UPDATE Appointments SET status = 'COMPLETED' WHERE appointment_id = 1;

-- Step 4: Bác sĩ kê đơn thuốc
INSERT INTO Prescriptions (appointment_id, medication_details)
VALUES (1, 'Paracetamol 500mg x 10 viên (Uong sang/chieu), Amoxicillin 500mg x 14 vien.');

-- Kịch bản 2: Hủy lịch và thu phí phạt
-- Step 1: Bệnh nhân B đặt lịch đã xác nhận cọc
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (2, 2, '2026-10-02 14:00:00', 'CONFIRMED', 300000.00);

-- Step 2: Hủy lịch, ghi nhận lý do và phạt tiền
UPDATE Appointments 
SET status = 'CANCELLED', 
    cancel_reason = 'Ban viec dot xuat', 
    penalty_fee = 150000.00 
WHERE appointment_id = 2;

-- Truy vấn kiểm tra kết quả danh sách bệnh nhân completed kèm đơn thuốc
SELECT 
    p.full_name AS PatientName,
    d.full_name AS DoctorName,
    a.appointment_date,
    a.status,
    pr.medication_details
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Prescriptions pr ON a.appointment_id = pr.appointment_id
WHERE a.status = 'COMPLETED';