use std::{fs, path::Path};

fn main() {
    let path = Path::new("./src/resources/input.txt");

    let (left_array, right_array): (Vec<usize>, Vec<usize>) = get_lists_from_file(path);

    let difference: usize = calculate_list_difference(&left_array, &right_array);

    let similarity_score: usize = calculate_similarity_score(&left_array, &right_array);

    println!("Total Difference between the two lists is: {}", difference);
    println!(
        "Similarity Score between the two lists is: {}",
        similarity_score
    );
}

pub fn calculate_list_difference(left_array: &[usize], right_array: &[usize]) -> usize {
    let difference: Vec<usize> = left_array
        .iter()
        .enumerate()
        .map(|(i, &x)| (x.abs_diff(right_array[i])))
        .collect();

    difference.iter().sum::<usize>()
}

pub fn get_lists_from_file(path: &Path) -> (Vec<usize>, Vec<usize>) {
    let file_contents = fs::read_to_string(path).unwrap();

    let lines = file_contents.lines();
    let mut left_array: Vec<usize> = vec![];
    let mut right_array: Vec<usize> = vec![];

    for line in lines {
        let row: Vec<&str> = line.split_whitespace().collect::<Vec<&str>>();

        left_array.push(row[0].parse::<usize>().unwrap());
        right_array.push(row[1].parse::<usize>().unwrap());
    }

    left_array.sort();
    right_array.sort();

    (left_array, right_array)
}

pub fn calculate_similarity_score(left_array: &[usize], right_array: &[usize]) -> usize {
    let mut similarity_score: Vec<usize> = vec![];

    for val in left_array {
        similarity_score.push(val * right_array.iter().filter(|x| *x == val).count());
    }

    similarity_score.iter().sum::<usize>()
}

#[cfg(test)]
pub mod tests {
    use super::*;

    #[test]
    fn should_return_list_of_differences_between_list_elements() {
        // Arrange
        let given_array1: Vec<usize> = vec![1, 2, 3];
        let given_array2: Vec<usize> = vec![1, 1, 4];
        let expected: Vec<usize> = vec![0, 1, 1];

        // Act
        let actual: Vec<usize> = calculate_list_difference(&given_array1, &given_array2);

        // Assert
        assert_eq!(actual, expected);
    }

    #[test]
    fn should_open_the_right_file_and_return_two_arrays() {
        // Arrange
        let path = Path::new("./src/resources/input.txt");

        let actual_arrays: (Vec<usize>, Vec<usize>) = get_lists_from_file(path);

        assert!(!actual_arrays.0.is_empty());
        assert!(!actual_arrays.1.is_empty());
    }

    #[test]
    fn given_different_lists_should_calculate_the_similarity_score_of_zero() {
        let first_array: Vec<usize> = vec![1, 2, 3];
        let second_array: Vec<usize> = vec![4, 5, 6];

        let actual: usize = calculate_similarity_score(&first_array, &second_array);

        assert_eq!(actual, 0);
    }

    #[test]
    fn given_similar_lists_should_calculate_the_similarity_score_of_31() {
        let first_array: Vec<usize> = vec![3, 4, 2, 1, 3, 3];
        let second_array: Vec<usize> = vec![4, 3, 5, 3, 9, 3];

        let actual: usize = calculate_similarity_score(&first_array, &second_array);

        assert_eq!(actual, 31);
    }
}
