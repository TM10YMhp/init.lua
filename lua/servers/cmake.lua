return {
  "cmake",
  setup = function()
    return {
      settings = {
        CMake = {
          filetypes = {
            "make", "CMakeLists.txt"
          }
        }
      }
    }
  end
}
