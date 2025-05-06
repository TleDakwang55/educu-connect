-- ตรวจสอบว่ามีตารางชื่อ teacher_course_assignments อยู่แล้วหรือไม่ ถ้ามี ให้ลบทิ้งก่อน (ระวังข้อมูลหาย)
-- DROP TABLE IF EXISTS teacher_course_assignments;

-- สร้างตาราง teacher_course_assignments
CREATE TABLE teacher_course_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY, -- รหัสอ้างอิงการสอน (Primary Key, Auto Increment)
    teacher_id VARCHAR(100) NOT NULL,             -- รหัสอาจารย์ (Foreign Key เชื่อมไปที่ users.staff_id) - ปรับขนาด VARCHAR(50) ให้ตรงกับขนาดของ staff_id ในตาราง users
    course_code VARCHAR(10) NOT NULL,                   -- รหัสวิชา (Foreign Key เชื่อมไปที่ courses.course_id)
    semester INT NOT NULL,                    -- ภาคการศึกษา (เช่น 1, 2, 3)
    academic_year INT NOT NULL,               -- ปีการศึกษา (พ.ศ.)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- เวลาที่เพิ่มข้อมูลนี้
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- เวลาที่อัปเดตข้อมูลนี้

    -- กำหนด Foreign Key Constraints
    -- ON DELETE CASCADE หมายความว่า ถ้าอาจารย์ถูกลบ ข้อมูลการสอนของอาจารย์คนนั้นในตารางนี้จะถูกลบไปด้วย
    -- ON UPDATE CASCADE หมายความว่า ถ้า teacher_id/staff_id ในตาราง users เปลี่ยน ข้อมูลในตารางนี้จะอัปเดตตาม
    FOREIGN KEY (teacher_id) REFERENCES users(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,

    -- ON DELETE CASCADE หมายความว่า ถ้าวิชาถูกลบ ข้อมูลการสอนของวิชานั้นในตารางนี้จะถูกลบไปด้วย
    -- ON UPDATE CASCADE หมายความว่า ถ้า course_id ในตาราง courses เปลี่ยน ข้อมูลในตารางนี้จะอัปเดตตาม
    FOREIGN KEY (course_code) REFERENCES courses(course_code) ON DELETE CASCADE ON UPDATE CASCADE,

    -- กำหนด Unique Constraint เพื่อป้องกันอาจารย์คนเดิมสอนวิชาเดิมในภาคการศึกษา/ปีการศึกษาเดียวกันซ้ำซ้อน
    UNIQUE (teacher_id, course_code, semester, academic_year)
);

-- อาจจะเพิ่ม INDEX บนคอลัมน์ teacher_id และ course_id เพื่อช่วยเรื่องประสิทธิภาพในการค้นหา
-- CREATE INDEX idx_teacher_id ON teacher_course_assignments (teacher_id);
-- CREATE INDEX idx_course_id ON teacher_course_assignments (course_id);