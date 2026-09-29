use std::io;

fn encipher(plaintext: &str, rails: usize, offset: usize) -> Result<String, String> {
    if rails == 0 {
        return Err("rails cannot be 0".to_string());
    }

    let plaintext: Vec<char> = plaintext.chars().collect();

    if rails == 1 {
        return Ok(plaintext.into_iter().collect());
    }
    if plaintext.len() <= 1 {
        return Ok(plaintext.into_iter().collect());
    }

    let period: usize = 2 * (rails - 1);
    let shift: usize = period - offset % period;
    let mut ciphertext = String::with_capacity(plaintext.len());

    for r in 0..rails {
        // First positions on rail r, going down and going up
        let down: usize = (r + shift) % period;
        let up: usize = (period - r + shift) % period;
        let (first, second) = if down <= up { (down, up) } else { (up, down) };

        let mut base: usize = 0;
        while base + first < plaintext.len() {
            ciphertext.push(plaintext[base + first]);
            // Top and bottom rails have only one position per period
            if first != second && base + second < plaintext.len() {
                ciphertext.push(plaintext[base + second]);
            }
            base += period;
        }
    }
    return Ok(ciphertext);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn empty() {
        assert!(encipher("", 0, 0).is_err());
        assert_eq!(encipher("", 5, 6).unwrap(), "");
        assert_eq!(encipher("", 1, 5).unwrap(), "");
    }

    #[test]
    fn regular() {
        assert_eq!(encipher("message", 3, 1).unwrap(), "smsaeeg");
        assert_eq!(encipher("message", 1, 0).unwrap(), "message");
        assert_eq!(encipher("message", 1, 1).unwrap(), "message");
        assert_eq!(encipher("message", 10, 1).unwrap(), "message");
        assert_eq!(encipher("message", 4, 5).unwrap(), "emsesga");
    }
}

fn main() -> Result<(), String> {
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("read failed");

    let mut it = input.split_whitespace();
    let plaintext = it.next().expect("missing text");
    let rails:  usize = it.next().expect("missing rails").parse().expect("rails: bad number");
    let offset: usize = it.next().expect("missing offset").parse().expect("offset: bad");

    println!("{}", encipher(plaintext, rails, offset)?);
    Ok(())
}
