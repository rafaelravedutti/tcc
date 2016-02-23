const float filter_mask[3][3] = {
    {0.057118f, 0.124758f, 0.057118f},
    {0.124758f, 0.272496f, 0.124758f},
    {0.057118f, 0.124758f, 0.057118f}
};

Mask<float> mask(filter_mask);

size_t width, height;
uchar *image = read_image(&width, &height, "input.pgm");
Image<uchar> in(width, height, image);

BoundaryCondition<uchar> cond(in, mask, Boundary::CLAMP);
Accessor<uchar> acc(cond);

Image<uchar> out(width, height);
IterationSpace<uchar> iter(out);

LinearFilter Gaussian(iter, acc, mask, 3);
Gaussian.execute();
