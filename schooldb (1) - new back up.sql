-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 28, 2026 at 12:38 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schooldb`
--

-- --------------------------------------------------------

--
-- Table structure for table `applicant`
--

CREATE TABLE `applicant` (
  `applicant_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `birth_date` date DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `campus_id` int(11) NOT NULL,
  `educational_background_category_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applicant`
--

INSERT INTO `applicant` (`applicant_id`, `first_name`, `middle_name`, `last_name`, `sex`, `birth_date`, `email`, `phone`, `campus_id`, `educational_background_category_id`, `created_at`) VALUES
(1, 'Juan', 'Santos', 'Dela Cruz', 'Male', '2005-05-10', 'juan@example.com', '09123456789', 1, 1, '2026-04-22 18:30:08'),
(2, 'Juan', 'Santos', 'Dela Cruz', 'Male', '2005-05-10', 'juan@example.com', '09123456789', 1, 1, '2026-04-22 18:30:18');

-- --------------------------------------------------------

--
-- Table structure for table `applicant_emergency_contact`
--

CREATE TABLE `applicant_emergency_contact` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `contact_name` varchar(150) NOT NULL,
  `relationship` varchar(100) DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `application_id` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `application_status_id` int(11) NOT NULL,
  `rejection_reason_id` int(11) DEFAULT NULL,
  `application_date` datetime DEFAULT current_timestamp(),
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `application`
--

INSERT INTO `application` (`application_id`, `applicant_id`, `program_id`, `application_status_id`, `rejection_reason_id`, `application_date`, `remarks`) VALUES
(1, 1, 1, 1, NULL, '2026-04-22 18:30:08', 'First test application'),
(2, 1, 1, 1, NULL, '2026-04-22 18:30:18', 'First test application');

-- --------------------------------------------------------

--
-- Table structure for table `application_status`
--

CREATE TABLE `application_status` (
  `application_status_id` int(11) NOT NULL,
  `application_status_name` varchar(10) DEFAULT NULL COMMENT 'pending, received, rejected',
  `application_status_description` text DEFAULT NULL,
  `application_status_color` varchar(10) NOT NULL,
  `application_status_is_final` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `application_status`
--

INSERT INTO `application_status` (`application_status_id`, `application_status_name`, `application_status_description`, `application_status_color`, `application_status_is_final`) VALUES
(1, 'pending', 'Waiting for review', 'yellow', 0),
(2, 'received', 'Application received', 'blue', 0),
(3, 'rejected', 'Application rejected', 'red', 1),
(4, 'pending', 'Waiting for review', 'yellow', 0),
(5, 'received', 'Application received', 'blue', 0),
(6, 'rejected', 'Application rejected', 'red', 1);

-- --------------------------------------------------------

--
-- Table structure for table `archived_record`
--

CREATE TABLE `archived_record` (
  `id` int(11) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` int(11) NOT NULL,
  `archived_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`archived_data`)),
  `archived_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campus`
--

CREATE TABLE `campus` (
  `campus_id` int(11) NOT NULL,
  `campus_name` varchar(255) DEFAULT NULL COMMENT 'Campus Name',
  `campus_location` varchar(255) DEFAULT NULL COMMENT 'Location of the campus'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campus`
--

INSERT INTO `campus` (`campus_id`, `campus_name`, `campus_location`) VALUES
(1, 'Main Campus', 'City Center'),
(2, 'Main Campus', 'City Center'),
(3, 'Main Campus', 'City Center');

-- --------------------------------------------------------

--
-- Table structure for table `curriculum_requirement`
--

CREATE TABLE `curriculum_requirement` (
  `id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `requirement_type_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deadline`
--

CREATE TABLE `deadline` (
  `id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `deadline_name` varchar(100) NOT NULL,
  `deadline_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `educational_background_category`
--

CREATE TABLE `educational_background_category` (
  `educational_background_category_id` int(11) NOT NULL,
  `educational_background_category_name` varchar(45) DEFAULT NULL CHECK (`educational_background_category_name` in ('old curriculum','SHS','College undergraduate','TVET','ALS')),
  `educational_background_category_code` varchar(45) DEFAULT NULL CHECK (`educational_background_category_code` in ('OLD','SHS','COL','TVET','ALS')),
  `educational_background_category_description` varchar(45) DEFAULT NULL COMMENT 'explanation of the curriculum',
  `educational_background_category_is_active` tinyint(1) DEFAULT 0,
  `educational_background_category_created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `educational_background_category`
--

INSERT INTO `educational_background_category` (`educational_background_category_id`, `educational_background_category_name`, `educational_background_category_code`, `educational_background_category_description`, `educational_background_category_is_active`, `educational_background_category_created_at`) VALUES
(1, 'old curriculum', 'OLD', 'Old basic education curriculum', 1, '2026-04-22 18:25:28'),
(2, 'SHS', 'SHS', 'Senior High School graduate', 1, '2026-04-22 18:25:28'),
(3, 'College undergraduate', 'COL', 'Has college units', 1, '2026-04-22 18:25:28'),
(4, 'TVET', 'TVET', 'Technical vocational track', 1, '2026-04-22 18:25:28'),
(5, 'ALS', 'ALS', 'Alternative Learning System', 1, '2026-04-22 18:25:28'),
(6, 'old curriculum', 'OLD', 'Old basic education curriculum', 1, '2026-04-22 18:25:31'),
(7, 'SHS', 'SHS', 'Senior High School graduate', 1, '2026-04-22 18:25:31'),
(8, 'College undergraduate', 'COL', 'Has college units', 1, '2026-04-22 18:25:31'),
(9, 'TVET', 'TVET', 'Technical vocational track', 1, '2026-04-22 18:25:31'),
(10, 'ALS', 'ALS', 'Alternative Learning System', 1, '2026-04-22 18:25:31');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `permission_id` int(11) NOT NULL,
  `permission_name` varchar(45) NOT NULL,
  `permission_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`permission_id`, `permission_name`, `permission_description`) VALUES
(1, 'manage_users', 'Can manage user accounts');

-- --------------------------------------------------------

--
-- Table structure for table `previous_education`
--

CREATE TABLE `previous_education` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `educational_background_category_id` int(11) DEFAULT NULL,
  `school_name` varchar(255) NOT NULL,
  `school_address` text DEFAULT NULL,
  `year_graduated` year(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program`
--

CREATE TABLE `program` (
  `program_id` int(11) NOT NULL,
  `program_code` varchar(45) DEFAULT NULL CHECK (`program_code` in ('BSIT','BSCS')),
  `program_name` varchar(255) DEFAULT NULL CHECK (`program_name` in ('Bachelor of Science in Information Technology','Bachelor of Science in Computer Science')),
  `program_is_active` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `program`
--

INSERT INTO `program` (`program_id`, `program_code`, `program_name`, `program_is_active`) VALUES
(1, 'BSIT', 'Bachelor of Science in Information Technology', 1),
(2, 'BSIT', 'Bachelor of Science in Information Technology', 1);

-- --------------------------------------------------------

--
-- Table structure for table `rejection_reason`
--

CREATE TABLE `rejection_reason` (
  `id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requirement`
--

CREATE TABLE `requirement` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `requirement_type_id` int(11) NOT NULL,
  `requirement_status_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requirement_status`
--

CREATE TABLE `requirement_status` (
  `requirement_status_id` int(11) NOT NULL,
  `requirement_status_name` varchar(45) DEFAULT NULL COMMENT 'pending, received, rejected, or resubmitted',
  `requirement_status_description` text DEFAULT NULL,
  `requirement_status_color` varchar(45) DEFAULT NULL,
  `requirement_status_is_final` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requirement_status`
--

INSERT INTO `requirement_status` (`requirement_status_id`, `requirement_status_name`, `requirement_status_description`, `requirement_status_color`, `requirement_status_is_final`) VALUES
(1, 'pending', 'Waiting for submission', 'yellow', 0),
(2, 'pending', 'Waiting for submission', 'yellow', 0);

-- --------------------------------------------------------

--
-- Table structure for table `requirement_submission`
--

CREATE TABLE `requirement_submission` (
  `requirement_submission_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `requirement_type_id` int(11) NOT NULL,
  `requirement_status_id` int(11) NOT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requirement_submission`
--

INSERT INTO `requirement_submission` (`requirement_submission_id`, `application_id`, `requirement_type_id`, `requirement_status_id`, `submitted_at`, `notes`) VALUES
(1, 1, 1, 1, '2026-04-22 18:30:08', 'Submitted initial requirement'),
(2, 1, 1, 1, '2026-04-22 18:30:18', 'Submitted initial requirement');

-- --------------------------------------------------------

--
-- Table structure for table `requirement_type`
--

CREATE TABLE `requirement_type` (
  `requirement_type_id` int(11) NOT NULL,
  `requirement_type_name` varchar(45) DEFAULT NULL CHECK (`requirement_type_name` in ('psa','tor','medical'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requirement_type`
--

INSERT INTO `requirement_type` (`requirement_type_id`, `requirement_type_name`) VALUES
(1, 'psa'),
(2, 'psa');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(45) NOT NULL,
  `role_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `role_description`) VALUES
(1, 'Admin', 'System administrator');

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracking_sequences`
--

CREATE TABLE `tracking_sequences` (
  `tracking_sequences_id` int(11) NOT NULL,
  `tracking_sequences_entity_type` enum('STU','DOC') NOT NULL,
  `tracking_sequences_prefix` varchar(10) NOT NULL,
  `tracking_sequences_last_sequence` int(11) NOT NULL DEFAULT 0,
  `tracking_sequences_current_year` int(11) NOT NULL,
  `tracking_sequences_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `tracking_sequences`
--

INSERT INTO `tracking_sequences` (`tracking_sequences_id`, `tracking_sequences_entity_type`, `tracking_sequences_prefix`, `tracking_sequences_last_sequence`, `tracking_sequences_current_year`, `tracking_sequences_updated_at`) VALUES
(1, 'STU', 'STU', 0, 2026, '2026-04-22 10:25:28'),
(2, 'DOC', 'DOC', 0, 2026, '2026-04-22 10:25:28'),
(3, 'STU', 'STU', 0, 2026, '2026-04-22 10:25:31'),
(4, 'DOC', 'DOC', 0, 2026, '2026-04-22 10:25:31');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_activity_log`
--

CREATE TABLE `user_activity_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applicant`
--
ALTER TABLE `applicant`
  ADD PRIMARY KEY (`applicant_id`),
  ADD KEY `campus_id` (`campus_id`),
  ADD KEY `educational_background_category_id` (`educational_background_category_id`);

--
-- Indexes for table `applicant_emergency_contact`
--
ALTER TABLE `applicant_emergency_contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_emergency_contact_applicant` (`applicant_id`);

--
-- Indexes for table `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `applicant_id` (`applicant_id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `application_status_id` (`application_status_id`),
  ADD KEY `fk_application_rejection_reason` (`rejection_reason_id`);

--
-- Indexes for table `application_status`
--
ALTER TABLE `application_status`
  ADD PRIMARY KEY (`application_status_id`);

--
-- Indexes for table `archived_record`
--
ALTER TABLE `archived_record`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campus`
--
ALTER TABLE `campus`
  ADD PRIMARY KEY (`campus_id`);

--
-- Indexes for table `curriculum_requirement`
--
ALTER TABLE `curriculum_requirement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curriculum_requirement_program` (`program_id`),
  ADD KEY `fk_curriculum_requirement_requirement_type` (`requirement_type_id`);

--
-- Indexes for table `deadline`
--
ALTER TABLE `deadline`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_deadline_program` (`program_id`);

--
-- Indexes for table `educational_background_category`
--
ALTER TABLE `educational_background_category`
  ADD PRIMARY KEY (`educational_background_category_id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`permission_id`);

--
-- Indexes for table `previous_education`
--
ALTER TABLE `previous_education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_previous_education_applicant` (`applicant_id`),
  ADD KEY `fk_previous_education_category` (`educational_background_category_id`);

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`program_id`);

--
-- Indexes for table `rejection_reason`
--
ALTER TABLE `rejection_reason`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requirement`
--
ALTER TABLE `requirement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_requirement_application` (`application_id`),
  ADD KEY `fk_requirement_type` (`requirement_type_id`),
  ADD KEY `fk_requirement_status` (`requirement_status_id`);

--
-- Indexes for table `requirement_status`
--
ALTER TABLE `requirement_status`
  ADD PRIMARY KEY (`requirement_status_id`);

--
-- Indexes for table `requirement_submission`
--
ALTER TABLE `requirement_submission`
  ADD PRIMARY KEY (`requirement_submission_id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `requirement_type_id` (`requirement_type_id`),
  ADD KEY `requirement_status_id` (`requirement_status_id`);

--
-- Indexes for table `requirement_type`
--
ALTER TABLE `requirement_type`
  ADD PRIMARY KEY (`requirement_type_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_role_permission_role` (`role_id`),
  ADD KEY `fk_role_permission_permission` (`permission_id`);

--
-- Indexes for table `tracking_sequences`
--
ALTER TABLE `tracking_sequences`
  ADD PRIMARY KEY (`tracking_sequences_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_role` (`role_id`);

--
-- Indexes for table `user_activity_log`
--
ALTER TABLE `user_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_activity_log_user` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applicant`
--
ALTER TABLE `applicant`
  MODIFY `applicant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `applicant_emergency_contact`
--
ALTER TABLE `applicant_emergency_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application`
--
ALTER TABLE `application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `application_status`
--
ALTER TABLE `application_status`
  MODIFY `application_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `archived_record`
--
ALTER TABLE `archived_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `campus`
--
ALTER TABLE `campus`
  MODIFY `campus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `curriculum_requirement`
--
ALTER TABLE `curriculum_requirement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deadline`
--
ALTER TABLE `deadline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `educational_background_category`
--
ALTER TABLE `educational_background_category`
  MODIFY `educational_background_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `previous_education`
--
ALTER TABLE `previous_education`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program`
--
ALTER TABLE `program`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rejection_reason`
--
ALTER TABLE `rejection_reason`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requirement`
--
ALTER TABLE `requirement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requirement_status`
--
ALTER TABLE `requirement_status`
  MODIFY `requirement_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `requirement_submission`
--
ALTER TABLE `requirement_submission`
  MODIFY `requirement_submission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `requirement_type`
--
ALTER TABLE `requirement_type`
  MODIFY `requirement_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tracking_sequences`
--
ALTER TABLE `tracking_sequences`
  MODIFY `tracking_sequences_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_activity_log`
--
ALTER TABLE `user_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applicant`
--
ALTER TABLE `applicant`
  ADD CONSTRAINT `applicant_ibfk_1` FOREIGN KEY (`campus_id`) REFERENCES `campus` (`campus_id`),
  ADD CONSTRAINT `applicant_ibfk_2` FOREIGN KEY (`educational_background_category_id`) REFERENCES `educational_background_category` (`educational_background_category_id`);

--
-- Constraints for table `applicant_emergency_contact`
--
ALTER TABLE `applicant_emergency_contact`
  ADD CONSTRAINT `fk_emergency_contact_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `applicant` (`applicant_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `application`
--
ALTER TABLE `application`
  ADD CONSTRAINT `application_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicant` (`applicant_id`),
  ADD CONSTRAINT `application_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  ADD CONSTRAINT `application_ibfk_3` FOREIGN KEY (`application_status_id`) REFERENCES `application_status` (`application_status_id`),
  ADD CONSTRAINT `fk_application_rejection_reason` FOREIGN KEY (`rejection_reason_id`) REFERENCES `rejection_reason` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `curriculum_requirement`
--
ALTER TABLE `curriculum_requirement`
  ADD CONSTRAINT `fk_curriculum_requirement_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_curriculum_requirement_requirement_type` FOREIGN KEY (`requirement_type_id`) REFERENCES `requirement_type` (`requirement_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deadline`
--
ALTER TABLE `deadline`
  ADD CONSTRAINT `fk_deadline_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `previous_education`
--
ALTER TABLE `previous_education`
  ADD CONSTRAINT `fk_previous_education_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `applicant` (`applicant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_previous_education_category` FOREIGN KEY (`educational_background_category_id`) REFERENCES `educational_background_category` (`educational_background_category_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `requirement`
--
ALTER TABLE `requirement`
  ADD CONSTRAINT `fk_requirement_application` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_requirement_status` FOREIGN KEY (`requirement_status_id`) REFERENCES `requirement_status` (`requirement_status_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_requirement_type` FOREIGN KEY (`requirement_type_id`) REFERENCES `requirement_type` (`requirement_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requirement_submission`
--
ALTER TABLE `requirement_submission`
  ADD CONSTRAINT `requirement_submission_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  ADD CONSTRAINT `requirement_submission_ibfk_2` FOREIGN KEY (`requirement_type_id`) REFERENCES `requirement_type` (`requirement_type_id`),
  ADD CONSTRAINT `requirement_submission_ibfk_3` FOREIGN KEY (`requirement_status_id`) REFERENCES `requirement_status` (`requirement_status_id`);

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `fk_role_permission_permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_permission_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `user_activity_log`
--
ALTER TABLE `user_activity_log`
  ADD CONSTRAINT `fk_user_activity_log_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
