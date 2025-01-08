# orchestriongolangcontainer1

## Without //dd:span
- Expected to capture the curl call + gorilla mux router
![2025-01-08_11-33-40 (1)](https://github.com/user-attachments/assets/b5a11dc8-0c92-4f47-ba7c-0e93367f3e4e)

## With //dd:span on functions
- Expected to capture the apiHandler span on top of whats captured above.
- Should not need to handle context propagation.
![2025-01-08_12-28-35 (1)](https://github.com/user-attachments/assets/09b3db7a-beae-4485-aa50-2b946d822ba1)
