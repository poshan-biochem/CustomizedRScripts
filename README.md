#FilterGTF
This function reads a GTF file line by line (similar to awk), filters the lines that match or do not match specified patterns, and writes the results to an output file. 
Arguments:
input        - Path to the input GTF file.
output       - Path to the output file to save filtered lines.
patterns     - String or vector of strings to search for in the lines.
negateSearch - Logical; if TRUE, excludes lines matching the patterns.
chunk_size   - Number of lines to read and process in each chunk
