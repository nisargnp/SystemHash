# SystemHash
Determine if system files have been compromised by creating hash snapshot of files in important directories to compare against at a later time.

## Usage
- Creating hash snapshot:
  - `create_hash_snapshot.sh hash_store.txt`
- Comparing against existing hash snapshot:
  - `compare_hash_snapshot.sh hash_store.txt out_file.txt`