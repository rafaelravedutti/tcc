class LinearFilter : public Kernel <uchar> {
    private:
        Accessor<uchar> &input;
        Mask<float> &mask;
        size_t size;

    public:
        LinearFilter(IterationSpace<uchar> &iter, Accessor<uchar> &input, Mask<float> &mask, size_t size) :
        Kernel(iter), input(input), mask(mask), size(size) {
            add_accessor(&input);
        }

        void kernel() {
            float sum = 0;
            int range = size / 2;

            for(int yf = -range; yf <= range; ++yf) {
                for(int xf = -range; xf <= range; ++xf) {
                    sum += mask(xf, yf) * input(xf, yf);
                }
            }

            output() = (uchar) sum;
        }
}
