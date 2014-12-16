class FileLoader
  ROOT = 'C:\Users\Lior\Desktop\dependencies'

  def self.get_content(filename)
    f = File.open(ROOT + '\\' + filename, 'r')
    lines = f.readlines
    f.close

    lines
  end
end