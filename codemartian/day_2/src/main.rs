use std::fs;
use std::path::Path;

fn main() {
    let path = Path::new("./src/resources/input.txt");

    let file_contents = fs::read_to_string(path).unwrap();

    let reports = file_contents.lines();

    let count = reports
        .map(|x| {
            x.split_whitespace()
                .map(|y| y.parse::<usize>().unwrap())
                .collect()
        })
        .filter(|x| all_within_three(x) & all_ascending_or_descending(x))
        .count();

    println!("{count}");
}

pub fn all_ascending_or_descending(report: &Vec<usize>) -> bool {
    report.windows(2).all(|x| x[0] < x[1]) | report.windows(2).all(|x| x[0] > x[1])
}

pub fn all_within_three(report: &Vec<usize>) -> bool {
    report.windows(2).all(|x| x[0].abs_diff(x[1]) <= 3)
}

#[cfg(test)]
pub mod tests {
    use super::*;

    #[test]
    fn test_given_12345_when_all_ascending_or_descending_then_should_return_true() {
        // Arrange
        let test_level: Vec<usize> = vec![1, 2, 3, 4, 5];

        // Act
        let actual: bool = all_ascending_or_descending(&test_level);

        // Assert
        assert!(actual);
    }

    #[test]
    fn test_given_54321_when_all_ascending_or_descending_then_should_return_true() {
        // Arrange
        let test_level: Vec<usize> = vec![5, 4, 3, 2, 1];

        // Act
        let actual: bool = all_ascending_or_descending(&test_level);

        // Assert
        assert!(actual);
    }

    #[test]
    fn test_given_12321_when_all_ascending_or_descending_then_should_return_false() {
        let test_level: Vec<usize> = vec![1, 2, 3, 2, 1];

        let actual: bool = all_ascending_or_descending(&test_level);

        assert!(!actual)
    }

    #[test]
    fn test_given_12456_when_all_within_three_then_should_return_true() {
        // Arrange
        let test_level: Vec<usize> = vec![1, 2, 4, 5, 6];

        // Act
        let actual: bool = all_within_three(&test_level);

        // Assert
        assert!(actual);
    }

    #[test]
    fn test_given_12567_when_all_within_three_then_should_return_true() {
        // Arrange
        let test_level: Vec<usize> = vec![1, 2, 5, 6, 7];

        // Act
        let actual: bool = all_within_three(&test_level);

        // Assert
        assert!(actual);
    }

    #[test]
    fn test_given_12678_when_all_within_three_then_should_return_false() {
        // Arrange
        let test_level: Vec<usize> = vec![1, 2, 6, 7, 8];

        // Act
        let actual: bool = all_within_three(&test_level);

        // Assert
        assert!(!actual);
    }
}
