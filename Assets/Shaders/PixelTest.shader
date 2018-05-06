Shader "Art/DynamicGradation" {
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            const float PI = 3.1415926;

            struct VertexInput {
                float4 pos:  POSITION;    // 3D座標
                float2 uv:   TEXCOORD0;   // テクスチャ座標
            };

            struct VertexOutput {
                float4 sv_pos:    SV_POSITION; // 2D座標
                float2 uv:   TEXCOORD0;   // テクスチャ座標
            };

            // 頂点シェーダー
            VertexOutput vert (VertexInput input) {
                VertexOutput output;
                output.sv_pos = UnityObjectToClipPos(input.pos);
                output.uv = input.uv;

                return output;
            }

            // ピクセルシェーダー
            float4 frag (VertexOutput output) : SV_Target {
            	float2 pixel_pos = float2(output.uv.x * _ScreenParams.x, output.uv.y * _ScreenParams.y);
                return float4(1 - sin(pixel_pos.x/3) * 0.7, 1, 1 - sin(pixel_pos.y/3) * 0.7, 1);
                //return float4(sin(output.uv.x*100), sin(output.uv.y*100), 1, 1);
            }

            ENDCG
        }
    }
} 