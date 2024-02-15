defmodule BertMask do
  def output_mask() do
    IO.inspect({"Time start:", :calendar.local_time()})
    {:ok, model_info} = Bumblebee.load_model({:hf, "google-bert/bert-base-uncased"})
    IO.inspect({"Time after loading", :calendar.local_time()})
    {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "google-bert/bert-base-uncased"})

    IO.inspect({"Time after loading", :calendar.local_time()})
    serving = Bumblebee.Text.fill_mask(model_info, tokenizer)
    IO.inspect({"Time after filling", :calendar.local_time()})
    Nx.Serving.run(serving, "The capital of [MASK] is Paris.")
    IO.inspect({"Time after running", :calendar.local_time()})
  end
end
