function automatic t_Capability encCapabilityToCapability(bit t, t_EncCapability c);
    t_Capability sail_return;
    bit goto_then_3341 = 1'h0;
    bit goto_endif_3342 = 1'h0;
    bit goto_case_180 = 1'h0;
    bit goto_then_3339 = 1'h0;
    bit goto_endif_3340 = 1'h0;
    bit goto_case_181 = 1'h0;
    bit goto_then_3337 = 1'h0;
    bit goto_endif_3338 = 1'h0;
    bit goto_case_182 = 1'h0;
    bit goto_then_3335 = 1'h0;
    bit goto_endif_3336 = 1'h0;
    bit goto_case_183 = 1'h0;
    bit goto_then_3333 = 1'h0;
    bit goto_endif_3334 = 1'h0;
    bit goto_case_184 = 1'h0;
    bit goto_finish_match_179 = 1'h0;
    bit goto_then_3331 = 1'h0;
    bit goto_endif_3332 = 1'h0;
    bit goto_then_3329 = 1'h0;
    bit goto_endif_3330 = 1'h0;
    bit goto_then_3327 = 1'h0;
    bit goto_endif_3328 = 1'h0;
    bit zz4129;
    bit zz4130;
    bit zz4131;
    bit zz4132;
    bit zz4133;
    bit zz4134;
    bit zz4135;
    bit zz4136;
    bit zz4137;
    bit zz4138;
    bit zz4139;
    bit zz4140;
    logic zz4211;
    logic [5:0] zz4212;
    bit zz4141;
    logic [4:0] zz4161;
    logic [5:0] zz4210;
    sail_unit zz4162;
    logic [4:0] zz4199;
    logic [1:0] zz4200;
    bit zz4201;
    logic zz4202;
    logic zz4203;
    logic zz4204;
    sail_unit zz4209;
    sail_unit zz4208;
    sail_unit zz4207;
    sail_unit zz4206;
    sail_unit zz4205;
    logic [4:0] zz4191;
    logic [2:0] zz4192;
    bit zz4193;
    logic zz4194;
    logic zz4195;
    sail_unit zz4198;
    sail_unit zz4197;
    sail_unit zz4196;
    logic [4:0] zz4188;
    bit zz4189;
    sail_unit zz4190;
    logic [4:0] zz4182;
    logic [2:0] zz4183;
    bit zz4184;
    logic zz4185;
    logic zz4186;
    sail_unit zz4187;
    logic [4:0] zz4170;
    logic [1:0] zz4171;
    bit zz4172;
    logic zz4173;
    logic zz4174;
    logic zz4175;
    sail_unit zz4181;
    sail_unit zz4180;
    sail_unit zz4179;
    sail_unit zz4178;
    sail_unit zz4177;
    sail_unit zz4176;
    logic [4:0] zz4164;
    logic zz4165;
    logic zz4166;
    logic zz4167;
    sail_unit zz4169;
    sail_unit zz4168;
    sail_unit zz4163;
    logic [3:0] zz4142;
    logic [0:0] zz4156;
    bit zz4158;
    bit zz4159;
    logic [2:0] zz4160;
    logic [2:0] zz4157;
    logic [4:0] zz4143;
    bit zz4150;
    logic [3:0] zz4155;
    logic [3:0] zz4151;
    logic [127:0] zz4152;
    sail_bits zz4153;
    sail_bits zz4154;
    t_Capability zz4144;
    logic [0:0] zz4145;
    logic [8:0] zz4146;
    logic [8:0] zz4147;
    logic [31:0] zz4148;
    t_Capability zz4149;
    zz4129 = 1'h0;
    zz4130 = 1'h0;
    zz4131 = 1'h0;
    zz4132 = 1'h0;
    zz4133 = 1'h0;
    zz4134 = 1'h0;
    zz4135 = 1'h0;
    zz4136 = 1'h0;
    zz4137 = 1'h0;
    zz4138 = 1'h0;
    zz4139 = 1'h0;
    zz4212 = c.cperms;
    zz4211 = zz4212[5];
    zz4140 = bit_to_bool(zz4211);
    zz4141 = 1'h0;
    zz4210 = c.cperms;
    zz4161 = zz4210[4:0];
    zz4199 = zz4161;
    zz4200 = zz4199[4:3];
    zz4201 = zz4200 == 2'b11;
    if (!zz4201) begin
        goto_then_3341 = 1'h1;
    end else begin
        goto_then_3341 = 1'h0;
    end;
    if (!goto_then_3341) begin
        goto_endif_3342 = 1'h1;
    end;
    /* then_3341 */
    if (goto_endif_3342) begin

    end;
    if (!goto_endif_3342) begin
        goto_case_180 = 1'h1;
    end;
    /* endif_3342 */
    if (!goto_case_180) begin
        zz4202 = zz4199[2];
        zz4203 = zz4199[1];
        zz4204 = zz4199[0];
        zz4135 = 1'h1;
        zz4209 = SAIL_UNIT;
        zz4134 = 1'h1;
        zz4208 = SAIL_UNIT;
        zz4138 = 1'h1;
        zz4207 = SAIL_UNIT;
        zz4136 = bit_to_bool(zz4202);
        zz4206 = SAIL_UNIT;
        zz4137 = bit_to_bool(zz4203);
        zz4205 = SAIL_UNIT;
        zz4139 = bit_to_bool(zz4204);
        zz4162 = SAIL_UNIT;
    end;
    if (!goto_case_180) begin
        goto_finish_match_179 = 1'h1;
    end;
    /* case_180 */
    if (!goto_finish_match_179) begin
        zz4191 = zz4161;
        zz4192 = zz4191[4:2];
        zz4193 = zz4192 == 3'b101;
    end;
    if (!goto_finish_match_179) begin
        if (!zz4193) begin
            goto_then_3339 = 1'h1;
        end else begin
            goto_then_3339 = 1'h0;
        end;
    end;
    if (!(goto_finish_match_179 || goto_then_3339)) begin
        goto_endif_3340 = 1'h1;
    end;
    /* then_3339 */
    if (goto_endif_3340 || goto_finish_match_179) begin

    end;
    if (!(goto_endif_3340 || goto_finish_match_179)) begin
        goto_case_181 = 1'h1;
    end;
    /* endif_3340 */
    if (!(goto_case_181 || goto_finish_match_179)) begin
        zz4194 = zz4191[1];
        zz4195 = zz4191[0];
        zz4135 = 1'h1;
        zz4198 = SAIL_UNIT;
        zz4134 = 1'h1;
        zz4197 = SAIL_UNIT;
        zz4137 = bit_to_bool(zz4194);
        zz4196 = SAIL_UNIT;
        zz4139 = bit_to_bool(zz4195);
        zz4162 = SAIL_UNIT;
    end;
    if (!(goto_case_181 || goto_finish_match_179)) begin
        goto_finish_match_179 = 1'h1;
    end;
    /* case_181 */
    if (!goto_finish_match_179) begin
        zz4188 = zz4161;
        zz4189 = zz4188 == 5'b10000;
    end;
    if (!goto_finish_match_179) begin
        if (!zz4189) begin
            goto_then_3337 = 1'h1;
        end else begin
            goto_then_3337 = 1'h0;
        end;
    end;
    if (!(goto_finish_match_179 || goto_then_3337)) begin
        goto_endif_3338 = 1'h1;
    end;
    /* then_3337 */
    if (goto_endif_3338 || goto_finish_match_179) begin

    end;
    if (!(goto_endif_3338 || goto_finish_match_179)) begin
        goto_case_182 = 1'h1;
    end;
    /* endif_3338 */
    if (!(goto_case_182 || goto_finish_match_179)) begin
        zz4138 = 1'h1;
        zz4190 = SAIL_UNIT;
        zz4134 = 1'h1;
        zz4162 = SAIL_UNIT;
    end;
    if (!(goto_case_182 || goto_finish_match_179)) begin
        goto_finish_match_179 = 1'h1;
    end;
    /* case_182 */
    if (!goto_finish_match_179) begin
        zz4182 = zz4161;
        zz4183 = zz4182[4:2];
        zz4184 = zz4183 == 3'b100;
    end;
    if (!goto_finish_match_179) begin
        if (!zz4184) begin
            goto_then_3335 = 1'h1;
        end else begin
            goto_then_3335 = 1'h0;
        end;
    end;
    if (!(goto_finish_match_179 || goto_then_3335)) begin
        goto_endif_3336 = 1'h1;
    end;
    /* then_3335 */
    if (goto_endif_3336 || goto_finish_match_179) begin

    end;
    if (!(goto_endif_3336 || goto_finish_match_179)) begin
        goto_case_183 = 1'h1;
    end;
    /* endif_3336 */
    if (!(goto_case_183 || goto_finish_match_179)) begin
        zz4185 = zz4182[1];
        zz4186 = zz4182[0];
        zz4135 = bit_to_bool(zz4185);
        zz4187 = SAIL_UNIT;
        zz4138 = bit_to_bool(zz4186);
        zz4162 = SAIL_UNIT;
    end;
    if (!(goto_case_183 || goto_finish_match_179)) begin
        goto_finish_match_179 = 1'h1;
    end;
    /* case_183 */
    if (!goto_finish_match_179) begin
        zz4170 = zz4161;
        zz4171 = zz4170[4:3];
        zz4172 = zz4171 == 2'b01;
    end;
    if (!goto_finish_match_179) begin
        if (!zz4172) begin
            goto_then_3333 = 1'h1;
        end else begin
            goto_then_3333 = 1'h0;
        end;
    end;
    if (!(goto_finish_match_179 || goto_then_3333)) begin
        goto_endif_3334 = 1'h1;
    end;
    /* then_3333 */
    if (goto_endif_3334 || goto_finish_match_179) begin

    end;
    if (!(goto_endif_3334 || goto_finish_match_179)) begin
        goto_case_184 = 1'h1;
    end;
    /* endif_3334 */
    if (!(goto_case_184 || goto_finish_match_179)) begin
        zz4173 = zz4170[2];
        zz4174 = zz4170[1];
        zz4175 = zz4170[0];
        zz4141 = 1'h1;
        zz4181 = SAIL_UNIT;
        zz4132 = 1'h1;
        zz4180 = SAIL_UNIT;
        zz4135 = 1'h1;
        zz4179 = SAIL_UNIT;
        zz4134 = 1'h1;
        zz4178 = SAIL_UNIT;
        zz4133 = bit_to_bool(zz4173);
        zz4177 = SAIL_UNIT;
        zz4137 = bit_to_bool(zz4174);
        zz4176 = SAIL_UNIT;
        zz4139 = bit_to_bool(zz4175);
        zz4162 = SAIL_UNIT;
    end;
    if (!(goto_case_184 || goto_finish_match_179)) begin
        goto_finish_match_179 = 1'h1;
    end;
    /* case_184 */
    if (!goto_finish_match_179) begin
        zz4164 = zz4161;
        zz4165 = zz4164[2];
        zz4166 = zz4164[1];
        zz4167 = zz4164[0];
        zz4129 = bit_to_bool(zz4165);
        zz4169 = SAIL_UNIT;
        zz4130 = bit_to_bool(zz4166);
        zz4168 = SAIL_UNIT;
        zz4131 = bit_to_bool(zz4167);
        zz4162 = SAIL_UNIT;
    end;
    /* finish_match_179 */
    zz4163 = zz4162;
    if (zz4141) begin
        goto_then_3331 = 1'h1;
    end else begin
        goto_then_3331 = 1'h0;
    end;
    if (!goto_then_3331) begin
        zz4160 = c.cotype;
        zz4159 = zz4160 == 3'b000;
    end;
    if (!goto_then_3331) begin
        goto_endif_3332 = 1'h1;
    end;
    /* then_3331 */
    if (!goto_endif_3332) begin
        zz4159 = 1'h1;
    end;
    /* endif_3332 */
    zz4158 = zz4159;
    if (zz4158) begin
        goto_then_3329 = 1'h1;
    end else begin
        goto_then_3329 = 1'h0;
    end;
    if (!goto_then_3329) begin
        zz4156 = 1'b1;
    end;
    if (!goto_then_3329) begin
        goto_endif_3330 = 1'h1;
    end;
    /* then_3329 */
    if (!goto_endif_3330) begin
        zz4156 = 1'b0;
    end;
    /* endif_3330 */
    zz4157 = c.cotype;
    zz4142 = {zz4156, zz4157};
    zz4155 = c.cE;
    zz4150 = zz4155 == 4'hF;
    if (zz4150) begin
        goto_then_3327 = 1'h1;
    end else begin
        goto_then_3327 = 1'h0;
    end;
    if (!goto_then_3327) begin
        zz4151 = c.cE;
        zz4152 = 128'h00000000000000000000000000000005;
        zz4153 = '{8'h04, {124'h0000000000000000000000000000000, zz4151}};
        zz4154 = zero_extend(zz4152, zz4153);
        zz4143 = {zz4154.bits}[4:0];
    end;
    if (!goto_then_3327) begin
        goto_endif_3328 = 1'h1;
    end;
    /* then_3327 */
    if (!goto_endif_3328) begin
        zz4143 = 5'h18;
    end;
    /* endif_3328 */
    zz4145 = c.reserved;
    zz4146 = c.B;
    zz4147 = c.T;
    zz4148 = c.address;
    zz4149.B = zz4146;
    zz4149.E = zz4143;
    zz4149.T = zz4147;
    zz4149.access_system_regs = zz4133;
    zz4149.address = zz4148;
    zz4149.zglobal = zz4140;
    zz4149.otype = zz4142;
    zz4149.perm_user0 = zz4129;
    zz4149.permit_execute = zz4132;
    zz4149.permit_load = zz4135;
    zz4149.permit_load_global = zz4139;
    zz4149.permit_load_mutable = zz4137;
    zz4149.permit_load_store_cap = zz4134;
    zz4149.permit_seal = zz4130;
    zz4149.permit_store = zz4138;
    zz4149.permit_store_local_cap = zz4136;
    zz4149.permit_unseal = zz4131;
    zz4149.reserved = zz4145;
    zz4149.tag = t;
    zz4144 = zz4149;
    sail_return = zz4144;
    return sail_return;
endfunction

function automatic t_EncCapability capToEncCap(t_Capability cap);
    t_EncCapability sail_return;
    bit goto_then_3365 = 1'h0;
    bit goto_then_3367 = 1'h0;
    bit goto_endif_3368 = 1'h0;
    bit goto_endif_3366 = 1'h0;
    bit goto_then_3361 = 1'h0;
    bit goto_then_3363 = 1'h0;
    bit goto_endif_3364 = 1'h0;
    bit goto_endif_3362 = 1'h0;
    bit goto_then_3359 = 1'h0;
    bit goto_endif_3360 = 1'h0;
    bit goto_then_3357 = 1'h0;
    bit goto_endif_3358 = 1'h0;
    bit goto_then_3355 = 1'h0;
    bit goto_endif_3356 = 1'h0;
    bit goto_then_3353 = 1'h0;
    bit goto_endif_3354 = 1'h0;
    bit goto_then_3351 = 1'h0;
    bit goto_endif_3352 = 1'h0;
    bit goto_then_3349 = 1'h0;
    bit goto_endif_3350 = 1'h0;
    bit goto_then_3347 = 1'h0;
    bit goto_endif_3348 = 1'h0;
    bit goto_then_3345 = 1'h0;
    bit goto_endif_3346 = 1'h0;
    bit goto_then_3343 = 1'h0;
    bit goto_endif_3344 = 1'h0;
    logic [5:0] zz4214;
    logic zz4286;
    bit zz4288;
    sail_unit zz4287;
    bit zz4227;
    bit zz4282;
    bit zz4283;
    bit zz4284;
    bit zz4285;
    sail_unit zz4228;
    bit zz4238;
    bit zz4278;
    bit zz4279;
    bit zz4280;
    bit zz4281;
    bit zz4248;
    bit zz4276;
    bit zz4277;
    bit zz4255;
    bit zz4274;
    bit zz4275;
    bit zz4256;
    bit zz4272;
    bit zz4273;
    sail_unit zz4271;
    logic zz4268;
    bit zz4270;
    sail_unit zz4269;
    logic zz4265;
    bit zz4267;
    sail_unit zz4266;
    logic zz4263;
    bit zz4264;
    sail_unit zz4262;
    logic zz4259;
    bit zz4261;
    sail_unit zz4260;
    logic zz4257;
    bit zz4258;
    sail_unit zz4254;
    logic zz4251;
    bit zz4253;
    sail_unit zz4252;
    logic zz4249;
    bit zz4250;
    sail_unit zz4247;
    logic zz4244;
    bit zz4246;
    sail_unit zz4245;
    logic zz4241;
    bit zz4243;
    sail_unit zz4242;
    logic zz4239;
    bit zz4240;
    sail_unit zz4237;
    logic zz4234;
    bit zz4236;
    sail_unit zz4235;
    logic zz4231;
    bit zz4233;
    sail_unit zz4232;
    logic zz4229;
    bit zz4230;
    t_EncCapability zz4215;
    logic [0:0] zz4216;
    logic [2:0] zz4217;
    logic [3:0] zz4226;
    logic [3:0] zz4218;
    bit zz4223;
    logic [4:0] zz4225;
    logic [4:0] zz4224;
    logic [8:0] zz4219;
    logic [8:0] zz4220;
    logic [31:0] zz4221;
    t_EncCapability zz4222;
    zz4214 = 6'b000000;
    zz4288 = cap.zglobal;
    zz4286 = bool_to_bit(zz4288);
    zz4214 = {zz4286, zz4214[4:0]};
    zz4287 = SAIL_UNIT;
    zz4282 = cap.permit_execute;
    if (zz4282) begin
        goto_then_3365 = 1'h1;
    end else begin
        goto_then_3365 = 1'h0;
    end;
    if (!goto_then_3365) begin
        zz4283 = 1'h0;
    end;
    if (!goto_then_3365) begin
        goto_endif_3366 = 1'h1;
    end;
    /* then_3365 */
    if (!goto_endif_3366) begin
        zz4284 = cap.permit_load;
    end;
    if (!goto_endif_3366) begin
        if (zz4284) begin
            goto_then_3367 = 1'h1;
        end else begin
            goto_then_3367 = 1'h0;
        end;
    end;
    if (!(goto_endif_3366 || goto_then_3367)) begin
        zz4285 = 1'h0;
    end;
    if (!(goto_endif_3366 || goto_then_3367)) begin
        goto_endif_3368 = 1'h1;
    end;
    /* then_3367 */
    if (!(goto_endif_3366 || goto_endif_3368)) begin
        zz4285 = cap.permit_load_store_cap;
    end;
    /* endif_3368 */
    if (!goto_endif_3366) begin
        zz4283 = zz4285;
    end;
    /* endif_3366 */
    zz4227 = zz4283;
    if (zz4227) begin
        goto_then_3345 = 1'h1;
    end else begin
        goto_then_3345 = 1'h0;
    end;
    if (!goto_then_3345) begin
        zz4278 = cap.permit_load;
    end;
    if (!goto_then_3345) begin
        if (zz4278) begin
            goto_then_3361 = 1'h1;
        end else begin
            goto_then_3361 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3361)) begin
        zz4279 = 1'h0;
    end;
    if (!(goto_then_3345 || goto_then_3361)) begin
        goto_endif_3362 = 1'h1;
    end;
    /* then_3361 */
    if (!(goto_endif_3362 || goto_then_3345)) begin
        zz4280 = cap.permit_load_store_cap;
    end;
    if (!(goto_endif_3362 || goto_then_3345)) begin
        if (zz4280) begin
            goto_then_3363 = 1'h1;
        end else begin
            goto_then_3363 = 1'h0;
        end;
    end;
    if (!(goto_endif_3362 || goto_then_3345 || goto_then_3363)) begin
        zz4281 = 1'h0;
    end;
    if (!(goto_endif_3362 || goto_then_3345 || goto_then_3363)) begin
        goto_endif_3364 = 1'h1;
    end;
    /* then_3363 */
    if (!(goto_endif_3362 || goto_endif_3364 || goto_then_3345)) begin
        zz4281 = cap.permit_store;
    end;
    /* endif_3364 */
    if (!(goto_endif_3362 || goto_then_3345)) begin
        zz4279 = zz4281;
    end;
    /* endif_3362 */
    if (!goto_then_3345) begin
        zz4238 = zz4279;
    end;
    if (!goto_then_3345) begin
        if (zz4238) begin
            goto_then_3347 = 1'h1;
        end else begin
            goto_then_3347 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347)) begin
        zz4276 = cap.permit_load;
    end;
    if (!(goto_then_3345 || goto_then_3347)) begin
        if (zz4276) begin
            goto_then_3359 = 1'h1;
        end else begin
            goto_then_3359 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3359)) begin
        zz4277 = 1'h0;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3359)) begin
        goto_endif_3360 = 1'h1;
    end;
    /* then_3359 */
    if (!(goto_endif_3360 || goto_then_3345 || goto_then_3347)) begin
        zz4277 = cap.permit_load_store_cap;
    end;
    /* endif_3360 */
    if (!(goto_then_3345 || goto_then_3347)) begin
        zz4248 = zz4277;
    end;
    if (!(goto_then_3345 || goto_then_3347)) begin
        if (zz4248) begin
            goto_then_3349 = 1'h1;
        end else begin
            goto_then_3349 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        zz4274 = cap.permit_store;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        if (zz4274) begin
            goto_then_3357 = 1'h1;
        end else begin
            goto_then_3357 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3357)) begin
        zz4275 = 1'h0;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3357)) begin
        goto_endif_3358 = 1'h1;
    end;
    /* then_3357 */
    if (!(goto_endif_3358 || goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        zz4275 = cap.permit_load_store_cap;
    end;
    /* endif_3358 */
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        zz4255 = zz4275;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        if (zz4255) begin
            goto_then_3351 = 1'h1;
        end else begin
            goto_then_3351 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        zz4272 = cap.permit_load;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        if (zz4272) begin
            goto_then_3355 = 1'h1;
        end else begin
            goto_then_3355 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351 || goto_then_3355)) begin
        zz4273 = cap.permit_store;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351 || goto_then_3355)) begin
        goto_endif_3356 = 1'h1;
    end;
    /* then_3355 */
    if (!(goto_endif_3356 || goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        zz4273 = 1'h1;
    end;
    /* endif_3356 */
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        zz4256 = zz4273;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        if (zz4256) begin
            goto_then_3353 = 1'h1;
        end else begin
            goto_then_3353 = 1'h0;
        end;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351 || goto_then_3353)) begin
        zz4214 = {zz4214[5], {2'b00, zz4214[2:0]}};
        zz4271 = SAIL_UNIT;
        zz4270 = cap.perm_user0;
        zz4268 = bool_to_bit(zz4270);
        zz4214 = {zz4214[5:3], {zz4268, zz4214[1:0]}};
        zz4269 = SAIL_UNIT;
        zz4267 = cap.permit_seal;
        zz4265 = bool_to_bit(zz4267);
        zz4214 = {zz4214[5:2], {zz4265, zz4214[0]}};
        zz4266 = SAIL_UNIT;
        zz4264 = cap.permit_unseal;
        zz4263 = bool_to_bit(zz4264);
        zz4214 = {zz4214[5:1], zz4263};
        zz4228 = SAIL_UNIT;
    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351 || goto_then_3353)) begin
        goto_endif_3354 = 1'h1;
    end;
    /* then_3353 */
    if (!(goto_endif_3354 || goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        zz4214 = {zz4214[5], {3'b100, zz4214[1:0]}};
        zz4262 = SAIL_UNIT;
        zz4261 = cap.permit_load;
        zz4259 = bool_to_bit(zz4261);
        zz4214 = {zz4214[5:2], {zz4259, zz4214[0]}};
        zz4260 = SAIL_UNIT;
        zz4258 = cap.permit_store;
        zz4257 = bool_to_bit(zz4258);
        zz4214 = {zz4214[5:1], zz4257};
        zz4228 = SAIL_UNIT;
    end;
    /* endif_3354 */
    if (goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351) begin

    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349 || goto_then_3351)) begin
        goto_endif_3352 = 1'h1;
    end;
    /* then_3351 */
    if (!(goto_endif_3352 || goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        zz4214 = {zz4214[5], 5'b10000};
        zz4228 = SAIL_UNIT;
    end;
    /* endif_3352 */
    if (goto_then_3345 || goto_then_3347 || goto_then_3349) begin

    end;
    if (!(goto_then_3345 || goto_then_3347 || goto_then_3349)) begin
        goto_endif_3350 = 1'h1;
    end;
    /* then_3349 */
    if (!(goto_endif_3350 || goto_then_3345 || goto_then_3347)) begin
        zz4214 = {zz4214[5], {3'b101, zz4214[1:0]}};
        zz4254 = SAIL_UNIT;
        zz4253 = cap.permit_load_mutable;
        zz4251 = bool_to_bit(zz4253);
        zz4214 = {zz4214[5:2], {zz4251, zz4214[0]}};
        zz4252 = SAIL_UNIT;
        zz4250 = cap.permit_load_global;
        zz4249 = bool_to_bit(zz4250);
        zz4214 = {zz4214[5:1], zz4249};
        zz4228 = SAIL_UNIT;
    end;
    /* endif_3350 */
    if (goto_then_3345 || goto_then_3347) begin

    end;
    if (!(goto_then_3345 || goto_then_3347)) begin
        goto_endif_3348 = 1'h1;
    end;
    /* then_3347 */
    if (!(goto_endif_3348 || goto_then_3345)) begin
        zz4214 = {zz4214[5], {2'b11, zz4214[2:0]}};
        zz4247 = SAIL_UNIT;
        zz4246 = cap.permit_store_local_cap;
        zz4244 = bool_to_bit(zz4246);
        zz4214 = {zz4214[5:3], {zz4244, zz4214[1:0]}};
        zz4245 = SAIL_UNIT;
        zz4243 = cap.permit_load_mutable;
        zz4241 = bool_to_bit(zz4243);
        zz4214 = {zz4214[5:2], {zz4241, zz4214[0]}};
        zz4242 = SAIL_UNIT;
        zz4240 = cap.permit_load_global;
        zz4239 = bool_to_bit(zz4240);
        zz4214 = {zz4214[5:1], zz4239};
        zz4228 = SAIL_UNIT;
    end;
    /* endif_3348 */
    if (goto_then_3345) begin

    end;
    if (!goto_then_3345) begin
        goto_endif_3346 = 1'h1;
    end;
    /* then_3345 */
    if (!goto_endif_3346) begin
        zz4214 = {zz4214[5], {2'b01, zz4214[2:0]}};
        zz4237 = SAIL_UNIT;
        zz4236 = cap.access_system_regs;
        zz4234 = bool_to_bit(zz4236);
        zz4214 = {zz4214[5:3], {zz4234, zz4214[1:0]}};
        zz4235 = SAIL_UNIT;
        zz4233 = cap.permit_load_mutable;
        zz4231 = bool_to_bit(zz4233);
        zz4214 = {zz4214[5:2], {zz4231, zz4214[0]}};
        zz4232 = SAIL_UNIT;
        zz4230 = cap.permit_load_global;
        zz4229 = bool_to_bit(zz4230);
        zz4214 = {zz4214[5:1], zz4229};
        zz4228 = SAIL_UNIT;
    end;
    /* endif_3346 */
    zz4216 = cap.reserved;
    zz4226 = cap.otype;
    zz4217 = zz4226[2:0];
    zz4225 = cap.E;
    zz4223 = zz4225 == 5'h18;
    if (zz4223) begin
        goto_then_3343 = 1'h1;
    end else begin
        goto_then_3343 = 1'h0;
    end;
    if (!goto_then_3343) begin
        zz4224 = cap.E;
        zz4218 = zz4224[3:0];
    end;
    if (!goto_then_3343) begin
        goto_endif_3344 = 1'h1;
    end;
    /* then_3343 */
    if (!goto_endif_3344) begin
        zz4218 = 4'hF;
    end;
    /* endif_3344 */
    zz4219 = cap.T;
    zz4220 = cap.B;
    zz4221 = cap.address;
    zz4222.B = zz4220;
    zz4222.T = zz4219;
    zz4222.address = zz4221;
    zz4222.cE = zz4218;
    zz4222.cotype = zz4217;
    zz4222.cperms = zz4214;
    zz4222.reserved = zz4216;
    zz4215 = zz4222;
    sail_return = zz4215;
    return sail_return;
endfunction

function automatic bit bit_to_bool(logic b);
    bit sail_return;
    bit goto_then_3325 = 1'h0;
    bit goto_endif_3326 = 1'h0;
    bit goto_case_70 = 1'h0;
    bit goto_then_3323 = 1'h0;
    bit goto_endif_3324 = 1'h0;
    bit goto_case_71 = 1'h0;
    bit goto_finish_match_69 = 1'h0;
    bit zz428;
    logic zz431;
    bit zz432;
    logic zz429;
    bit zz430;
    zz431 = b;
    zz432 = zz431 == 1'b1;
    if (!zz432) begin
        goto_then_3325 = 1'h1;
    end else begin
        goto_then_3325 = 1'h0;
    end;
    if (!goto_then_3325) begin
        goto_endif_3326 = 1'h1;
    end;
    /* then_3325 */
    if (goto_endif_3326) begin

    end;
    if (!goto_endif_3326) begin
        goto_case_70 = 1'h1;
    end;
    /* endif_3326 */
    if (!goto_case_70) begin
        zz428 = 1'h1;
    end;
    if (!goto_case_70) begin
        goto_finish_match_69 = 1'h1;
    end;
    /* case_70 */
    if (!goto_finish_match_69) begin
        zz429 = b;
        zz430 = zz429 == 1'b0;
    end;
    if (!goto_finish_match_69) begin
        if (!zz430) begin
            goto_then_3323 = 1'h1;
        end else begin
            goto_then_3323 = 1'h0;
        end;
    end;
    if (!(goto_finish_match_69 || goto_then_3323)) begin
        goto_endif_3324 = 1'h1;
    end;
    /* then_3323 */
    if (goto_endif_3324 || goto_finish_match_69) begin

    end;
    if (!(goto_endif_3324 || goto_finish_match_69)) begin
        goto_case_71 = 1'h1;
    end;
    /* endif_3324 */
    if (!(goto_case_71 || goto_finish_match_69)) begin
        zz428 = 1'h0;
    end;
    if (!(goto_case_71 || goto_finish_match_69)) begin
        goto_finish_match_69 = 1'h1;
    end;
    /* case_71 */
    if (!goto_finish_match_69) begin
        begin   end
    end;
    /* finish_match_69 */
    sail_return = zz428;
    return sail_return;
endfunction

function automatic logic bool_to_bit(bit x);
    logic sail_return;
    bit goto_then_3321 = 1'h0;
    bit goto_endif_3322 = 1'h0;
    if (x) begin
        goto_then_3321 = 1'h1;
    end else begin
        goto_then_3321 = 1'h0;
    end;
    if (!goto_then_3321) begin
        sail_return = 1'b0;
    end;
    if (!goto_then_3321) begin
        goto_endif_3322 = 1'h1;
    end;
    /* then_3321 */
    if (!goto_endif_3322) begin
        sail_return = 1'b1;
    end;
    /* endif_3322 */
    return sail_return;
endfunction

function automatic sail_bits to_bits(logic [127:0] l, logic [127:0] n);
    sail_bits sail_return;
    sail_return = '{l[7:0], (~(128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF << signed'({120'h000000000000000000000000000000, l[7:0]}))) & n};
    return sail_return;
endfunction

function automatic sail_bits zero_extend(logic [127:0] m, sail_bits v);
    sail_bits sail_return;
    sail_return = '{m[7:0], v.bits};
    return sail_return;
endfunction

function automatic t_Capability capBitsToCapability(bit t, logic [63:0] c);
    t_Capability sail_return;
    t_EncCapability zz4213;
    zz4213 = capBitsToEncCapability(c);
    sail_return = encCapabilityToCapability(t, zz4213);
    return sail_return;
endfunction

function automatic t_EncCapability capBitsToEncCapability(logic [63:0] c);
    t_EncCapability sail_return;
    logic [0:0] zz477;
    logic [5:0] zz478;
    logic [2:0] zz479;
    logic [3:0] zz480;
    logic [8:0] zz481;
    logic [8:0] zz482;
    logic [31:0] zz483;
    t_EncCapability zz484;
    zz477 = c[63];
    zz478 = c[62:57];
    zz479 = c[56:54];
    zz480 = c[53:50];
    zz481 = c[49:41];
    zz482 = c[40:32];
    zz483 = c[31:0];
    zz484.B = zz482;
    zz484.T = zz481;
    zz484.address = zz483;
    zz484.cE = zz480;
    zz484.cotype = zz479;
    zz484.cperms = zz478;
    zz484.reserved = zz477;
    sail_return = zz484;
    return sail_return;
endfunction

