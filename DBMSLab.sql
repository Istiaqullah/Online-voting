SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+06:00";


-- Database: `dbmslab`

CREATE TABLE `candidates` (
  `CandidateID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `cname` varchar(255) NOT NULL,
  `Photo` varchar(255) DEFAULT NULL,
  `ElectionID` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `candidates` (`CandidateID`, `UserID`, `cname`, `Photo`, `ElectionID`, `status`) VALUES
(35, 62233, 'candidate1', '../uploads/candidate.png', 162, 0),
(36, 27457, 'candidate2', '../uploads/candidate2.png', 162, 0);

-- Table structure for table `elections`

CREATE TABLE `elections` (
  `ElectionID` int(11) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `elections` (`ElectionID`, `Title`, `Description`, `Start_Date`, `End_Date`, `status`) VALUES
(162, 'class representative election', 'students need to choose the class representative for class who act as leader ,co-ordinator etc... to the students ', '2024-07-15', '2024-07-16', 'Ongoing');

-- Table structure for table `positions`

CREATE TABLE `positions` (
  `PositionID` int(11) NOT NULL,
  `ElectionID` int(11) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `positions` (`PositionID`, `ElectionID`, `Title`, `Description`) VALUES
(37, 162, 'class representative', 'Some Position Description');


-- Table structure for table `users`

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `NID` varchar(10) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Photo` varchar(255) DEFAULT NULL,
  `Role` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`UserID`, `Username`, `NID`, `Password`, `Photo`, `Role`) VALUES
(2958, 'user3', '3456789012', '$2y$10$OiHQe9wUnzIbek2ZlR./3eQlva/wMoabtKitoQS/MrKGSXaYTAJ8.', '../uploads/voter3.png', 'voter'),
(27457, 'candidate2', '5678901234', '$2y$10$VgnCheZbA62W1r6tvMZwmuor7MvCzstssW5ozyyCLRhc9omTY0p1y', '../uploads/candidate2.png', 'candidate'),
(30310, 'user2', '2345678901', '$2y$10$GSWiV7QppI3yghVTsOiJuuRL1zFHQONnIjy4dAv4lDWs/k6yo3s8O', '../uploads/voter2.png', 'voter'),
(42032, 'user1', '1234567890', '$2y$10$sCe7Cdw0.H6vmtkak4GdvuKUoLZeHuFuMBrw/oG6/uOquHS54Pfaa', '../uploads/voter1.png', 'voter'),
(62233, 'candidate1', '4567890123', '$2y$10$WBsr1.kuMq/tYmAhPKqC9eMsGXKgDK/aed.EjmzpdsEo6eUU/oCwC', '../uploads/candidate.png', 'candidate');

-- Table structure for table `votes`

CREATE TABLE `votes` (
  `VoteID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `ElectionID` int(11) DEFAULT NULL,
  `CandidateID` int(11) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `votes` (`VoteID`, `UserID`, `ElectionID`, `CandidateID`, `Timestamp`) VALUES
(1, 42032, 162, 35, '2024-07-15 09:52:42'),
(2, 30310, 162, 36, '2024-07-15 09:53:51'),
(3, 2958, 162, 35, '2024-07-15 09:54:11'),
(4, 62233, 162, 36, '2024-07-15 09:54:31'),
(5, 27457, 162, 35, '2024-07-15 09:54:56');

-- Indexes for table `candidates`
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`CandidateID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ElectionID` (`ElectionID`);

-- Indexes for table `elections`
ALTER TABLE `elections`
  ADD PRIMARY KEY (`ElectionID`);

-- Indexes for table `positions`
ALTER TABLE `positions`
  ADD PRIMARY KEY (`PositionID`),
  ADD KEY `ElectionID` (`ElectionID`);

-- Indexes for table `users`
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

-- Indexes for table `votes`
ALTER TABLE `votes`
  ADD PRIMARY KEY (`VoteID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ElectionID` (`ElectionID`),
  ADD KEY `CandidateID` (`CandidateID`);

-- AUTO_INCREMENT for table `candidates`
ALTER TABLE `candidates`
  MODIFY `CandidateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

-- AUTO_INCREMENT for table `elections`
ALTER TABLE `elections`
  MODIFY `ElectionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

-- AUTO_INCREMENT for table `positions`
ALTER TABLE `positions`
  MODIFY `PositionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

-- AUTO_INCREMENT for table `users`
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65024;

-- AUTO_INCREMENT for table `votes`
ALTER TABLE `votes`
  MODIFY `VoteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


-- Constraints for table `candidates`
ALTER TABLE `candidates`
  ADD CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `candidates_ibfk_2` FOREIGN KEY (`ElectionID`) REFERENCES `elections` (`ElectionID`);

-- Constraints for table `positions`
ALTER TABLE `positions`
  ADD CONSTRAINT `positions_ibfk_1` FOREIGN KEY (`ElectionID`) REFERENCES `elections` (`ElectionID`);

-- Constraints for table `votes`
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`ElectionID`) REFERENCES `elections` (`ElectionID`),
  ADD CONSTRAINT `votes_ibfk_3` FOREIGN KEY (`CandidateID`) REFERENCES `candidates` (`CandidateID`);
COMMIT;