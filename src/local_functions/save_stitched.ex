def function(final_stitched) do
  # join the array of strings
  final_stitched_str = Enum.join(final_stitched, " ")

  # save the stitched story to a file
  File.write("final_stitched.txt", final_stitched_str)
end
