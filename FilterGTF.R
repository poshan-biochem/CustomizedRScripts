FilterGTF <- function(input, output, patterns, negate_search = FALSE, chunk_size = 1000) {
  # Start time tracking
  start_time <- Sys.time()
  
  # Ensure the necessary library is loaded
  if (!requireNamespace("stringi", quietly = TRUE)) {
    stop("The 'stringi' package is required but not installed.")
  }
  library(stringi)
  # Open I/O connections
  input_conn <- tryCatch({
    file(input, open = "r")
  }, error = function(e) {
    stop("Error opening input file: ", e$message)
  })
  
  output_conn <- tryCatch({
    file(output, open = "w")
  }, error = function(e) {
    close(input_conn)
    stop("Error opening output file: ", e$message)
  })
  
  # Initialize line count
  total_written <- 0
  # Process lines in chunks
  repeat {
    lines <- readLines(input_conn, n = chunk_size, warn = FALSE)
    if (length(lines) == 0) break 
    
    # Filter lines based on patterns and negateSearch flag
    filtered_lines <- lines[stri_detect_fixed(lines, patterns, negate = negate_search)]
  
    # Count the filtered lines
    total_written <- total_written + length(filtered_lines)
    
    # Write filtered lines to the output file
    writeLines(text = filtered_lines, con = output_conn)
  }
  
  # Close connections
  close(input_conn)
  close(output_conn)
  
  # End time tracking
  end_time <- Sys.time()
  time_taken <- end_time - start_time
  
  # Print timing information and total lines written
  cat("Filtering completed! \n")
  cat("Total lines written:", total_written, "\n")
  cat( time_taken, "seconds elapsed.\n")
}
