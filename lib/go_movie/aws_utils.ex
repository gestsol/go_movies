defmodule GoMovie.AWSUtils do
  def delete_multiple_images_from_S3(resource, bucket, fields) do
    Enum.each(fields, fn f ->
      img_url = Map.get(resource, f)
      if img_url do
        delete_image_from_S3(img_url, bucket)
      end
    end)
  end

  def delete_image_from_S3(img_path, bucket) do
    case extract_S3_filename(img_path, bucket) do
      {:error, _message} -> nil
      filename -> ExAws.S3.delete_object(bucket, filename) |> ExAws.request()
    end
  end

  def extract_S3_filename(path, bucket) do
    start_index = case :binary.match(path, bucket <> "/") do
      :nomatch -> nil
      {start_index, _length} -> start_index
    end

    if start_index do
      String.slice(path, start_index..-1) |> String.replace(bucket <> "/", "")
    else
      {:error, "Bucket: #{bucket} is not present in path: #{path}"}
    end
  end
end
