
CREATE DATABASE IF NOT EXISTS EasypayDB;
USE EasypayDB;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    dob DATE,
    doj DATE,
    designation VARCHAR(100),
    department VARCHAR(100),
    manager_id INT,
    user_id INT UNIQUE,
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

CREATE TABLE payroll (
    payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    final_take_home DECIMAL(10,2),
    month_year VARCHAR(20),
    status VARCHAR(20),
    generated_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
);

CREATE TABLE payroll_config (
    config_id INT AUTO_INCREMENT PRIMARY KEY,
    config_name VARCHAR(100),
    description TEXT,
    effective_date DATE
);

CREATE TABLE payroll_config_allowances (
    allowance_id INT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    allowance_name VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (config_id) REFERENCES payroll_config(config_id) ON DELETE CASCADE
);

CREATE TABLE payroll_config_deductions (
    deduction_id INT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    deduction_name VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (config_id) REFERENCES payroll_config(config_id) ON DELETE CASCADE
);

CREATE TABLE leave_request (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    leave_type VARCHAR(50),
    from_date DATE,
    to_date DATE,
    reason TEXT,
    status VARCHAR(20),
    approved_by VARCHAR(100),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
);

CREATE TABLE timesheet (
    timesheet_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    date DATE,
    hours_worked DECIMAL(5,2),
    task_description TEXT,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
);

CREATE TABLE notification (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    message TEXT,
    status VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
);

CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE SET NULL
);
