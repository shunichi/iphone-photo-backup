class Meta
  BLOCK_SIZE = 8 * 1024

  attr_reader :path, :mtime, :size

  def initialize(path, mtime, size)
    @path = path
    @mtime = mtime
    @size = size
  end

  def storage_size
    (size + BLOCK_SIZE - 1) / BLOCK_SIZE * BLOCK_SIZE
  end
end
