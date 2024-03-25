from pathlib import Path


class Converter():

    def __init__(self, phrase) -> None:
        self.phrase = "Hello, World!" if phrase is None else phrase
        self.bit_stream = self.__convert_to_bit(self.phrase)
        self.write_to_file(self.bit_stream)
        # self.write_start_stop_bits() Czy chodzi o bit pierwszy i ostatni?

    def __convert_to_bit(self, phrase: str) -> int:
        return ''.join(format(ord(i), '08b') for i in phrase)
    
    def write_to_file(self, bit_stream: int, file_name: str = "bit_stream_input.bin") -> None:
        with open(file_name, "wb") as f:
            f.write(bit_stream.encode())

    def write_start_stop_bits(self, file_name: str = "bit_start_stop.bin") -> None:
        with open(file_name, "ab") as f:
            f.write(b'1')
            f.write(b'0')

converter = Converter("Hello, World!")