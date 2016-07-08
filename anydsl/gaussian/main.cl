
__kernel void lambda_crit_1733(int, int, int, int*, int);
int acc_bidx_2098();
int acc_bdimx_2113();
int acc_tidx_2127();
int acc_bidy_2141();
int acc_bdimy_2152();
int acc_tidy_2162();

__kernel void lambda_crit_1733(int _1736_2093, int _1737_2094, int _1738_2095, int* _1739_2096, int _1740_2097) {
    int  acc_bidx_2112;
    int pacc_bidx_2112;
    int  acc_bdimx_2126;
    int pacc_bdimx_2126;
    int  acc_tidx_2140;
    int pacc_tidx_2140;
    int  acc_bidy_2151;
    int pacc_bidy_2151;
    int  acc_bdimy_2161;
    int pacc_bdimy_2161;
    int  acc_tidy_2171;
    int pacc_tidy_2171;
    int  min_2173;
    int pmin_2173;
    int*  data_2175;
    int* pdata_2175;
    int  min_2179;
    int pmin_2179;
    acc_bidx_2112 = acc_bidx_2098();
    pacc_bidx_2112 = acc_bidx_2112;
    l2110: ;
        acc_bidx_2112 = pacc_bidx_2112;
        acc_bdimx_2126 = acc_bdimx_2113();
        pacc_bdimx_2126 = acc_bdimx_2126;
    l2124: ;
        acc_bdimx_2126 = pacc_bdimx_2126;
        acc_tidx_2140 = acc_tidx_2127();
        pacc_tidx_2140 = acc_tidx_2140;
    l2138: ;
        acc_tidx_2140 = pacc_tidx_2140;
        acc_bidy_2151 = acc_bidy_2141();
        pacc_bidy_2151 = acc_bidy_2151;
    l2149: ;
        acc_bidy_2151 = pacc_bidy_2151;
        acc_bdimy_2161 = acc_bdimy_2152();
        pacc_bdimy_2161 = acc_bdimy_2161;
    l2159: ;
        acc_bdimy_2161 = pacc_bdimy_2161;
        acc_tidy_2171 = acc_tidy_2162();
        pacc_tidy_2171 = acc_tidy_2171;
    l2169: ;
        acc_tidy_2171 = pacc_tidy_2171;
        int _2184;
        _2184 = acc_bidx_2112 * acc_bdimx_2126;
        int x_2185;
        x_2185 = _2184 + acc_tidx_2140;
        int _2191;
        _2191 = acc_bidy_2151 * acc_bdimy_2161;
        int y_2192;
        y_2192 = _2191 + acc_tidy_2171;
        pmin_2173 = _1738_2095;
        pdata_2175 = _1739_2096;
        goto l2172;
    l2172: ;
        min_2173 = pmin_2173;
        data_2175 = pdata_2175;
        bool _2176;
        _2176 = min_2173 < _1737_2094;
        if (_2176) goto l2177; else goto l2208;
    l2208: ;
        int _2209;
        _2209 = y_2192 * _1740_2097;
        int _2210;
        _2210 = _2209 + x_2185;
        int* _2211;
        _2211 = data_2175 + _2210;
        *_2211 = 0;
        return ;
    l2177: ;
        int _2186;
        _2186 = x_2185 + min_2173;
        bool _2187;
        _2187 = -1 < _2186;
        bool _2189;
        _2189 = _2186 < _1740_2097;
        pmin_2179 = _1738_2095;
        goto l2178;
    l2178: ;
        min_2179 = pmin_2179;
        bool _2181;
        _2181 = min_2179 < _1737_2094;
        if (_2181) goto l2182; else goto l2206;
    l2206: ;
        int _2207;
        _2207 = 1 + min_2173;
        pmin_2173 = _2207;
        pdata_2175 = data_2175;
        goto l2172;
    l2182: ;
        if (_2187) goto l2188; else goto l2205;
    l2205: ;
        goto l2202;
    l2188: ;
        if (_2189) goto l2190; else goto l2204;
    l2204: ;
        goto l2202;
    l2190: ;
        int _2193;
        _2193 = y_2192 + min_2179;
        bool _2194;
        _2194 = -1 < _2193;
        if (_2194) goto l2195; else goto l2203;
    l2203: ;
        goto l2202;
    l2195: ;
        bool _2196;
        _2196 = _2193 < _1736_2093;
        if (_2196) goto l2197; else goto l2201;
    l2201: ;
        goto l2202;
    l2202: ;
        goto l2198;
    l2197: ;
        goto l2198;
    l2198: ;
        int _2200;
        _2200 = 1 + min_2179;
        pmin_2179 = _2200;
        goto l2178;
}

int acc_bidx_2098() {
    unsigned long  get_group_id_2108;
    unsigned long pget_group_id_2108;
    get_group_id_2108 = get_group_id(0);
    pget_group_id_2108 = get_group_id_2108;
    l2106: ;
        get_group_id_2108 = pget_group_id_2108;
        int _2109;
        _2109 = (int)get_group_id_2108;
        return _2109;
}

int acc_bdimx_2113() {
    unsigned long  get_local_size_2122;
    unsigned long pget_local_size_2122;
    get_local_size_2122 = get_local_size(0);
    pget_local_size_2122 = get_local_size_2122;
    l2120: ;
        get_local_size_2122 = pget_local_size_2122;
        int _2123;
        _2123 = (int)get_local_size_2122;
        return _2123;
}

int acc_tidx_2127() {
    unsigned long  get_local_id_2136;
    unsigned long pget_local_id_2136;
    get_local_id_2136 = get_local_id(0);
    pget_local_id_2136 = get_local_id_2136;
    l2134: ;
        get_local_id_2136 = pget_local_id_2136;
        int _2137;
        _2137 = (int)get_local_id_2136;
        return _2137;
}

int acc_bidy_2141() {
    unsigned long  get_group_id_2147;
    unsigned long pget_group_id_2147;
    get_group_id_2147 = get_group_id(1);
    pget_group_id_2147 = get_group_id_2147;
    l2145: ;
        get_group_id_2147 = pget_group_id_2147;
        int _2148;
        _2148 = (int)get_group_id_2147;
        return _2148;
}

int acc_bdimy_2152() {
    unsigned long  get_local_size_2157;
    unsigned long pget_local_size_2157;
    get_local_size_2157 = get_local_size(1);
    pget_local_size_2157 = get_local_size_2157;
    l2155: ;
        get_local_size_2157 = pget_local_size_2157;
        int _2158;
        _2158 = (int)get_local_size_2157;
        return _2158;
}

int acc_tidy_2162() {
    unsigned long  get_local_id_2167;
    unsigned long pget_local_id_2167;
    get_local_id_2167 = get_local_id(1);
    pget_local_id_2167 = get_local_id_2167;
    l2165: ;
        get_local_id_2167 = pget_local_id_2167;
        int _2168;
        _2168 = (int)get_local_id_2167;
        return _2168;
}

