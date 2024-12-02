use std::{fs, path::Path};

fn main() {
    let path = Path::new("./src/resources/input.txt");

    let (left_array, right_array) = get_lists_from_file(path);

    let differences = calculate_list_differences(&left_array, &right_array);

    println!("{}", differences.iter().sum::<i32>());
}

pub fn calculate_list_differences(left_array: &[i32], right_array: &[i32]) -> Vec<i32> {
    let difference: Vec<i32> = left_array
        .iter()
        .enumerate()
        .map(|(i, &x)| (x - right_array[i]).abs())
        .collect();

    difference
}

pub fn get_lists_from_file(path: &Path) -> (Vec<i32>, Vec<i32>) {
    let file_contents = fs::read_to_string(path).unwrap();

    let lines = file_contents.lines();
    let mut left_array: Vec<i32> = vec![];
    let mut right_array: Vec<i32> = vec![];

    for line in lines {
        let row: Vec<&str> = line.split_whitespace().collect::<Vec<&str>>();

        left_array.push(row[0].parse::<i32>().unwrap());
        right_array.push(row[1].parse::<i32>().unwrap());
    }

    left_array.sort();
    right_array.sort();

    (left_array, right_array)
}

#[cfg(test)]
pub mod tests {
    use super::*;

    #[test]
    fn should_return_list_of_differences_between_list_elements() {
        // Arrange
        let given_array1: Vec<i32> = vec![1, 2, 3];
        let given_array2: Vec<i32> = vec![1, 1, 4];
        let expected: Vec<i32> = vec![0, 1, 1];

        // Act
        let actual: Vec<i32> = calculate_list_differences(&given_array1, &given_array2);

        // Assert
        assert_eq!(actual, expected);
    }

    #[test]
    fn should_open_the_right_file_and_return_two_arrays() {
        // Arrange
        let path = Path::new("./src/resources/input.txt");

        let actual_arrays: (Vec<i32>, Vec<i32>) = get_lists_from_file(path);

        assert!(!actual_arrays.0.is_empty());
        assert!(!actual_arrays.1.is_empty());
    }
}
