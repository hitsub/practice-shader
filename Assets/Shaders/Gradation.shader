Shader "Custom/Gradation" {
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct VertexInput {
                float4 pos:  POSITION;    // 3D座標
                float2 uv:   TEXCOORD0;   // テクスチャ座標
            };

            struct VertexOutput {
                float4 v:    SV_POSITION; // 2D座標
                float2 uv:   TEXCOORD0;   // テクスチャ座標
            };

            // 頂点シェーダー
            VertexOutput vert(VertexInput input) {
                VertexOutput output;
                output.v = UnityObjectToClipPos(input.pos);
                output.uv = input.uv;

                return output;
            }

            // ピクセルシェーダー
            float4 frag( VertexOutput output) : SV_Target {
                float2 tex = output.uv;
                return float4( tex.x, tex.x, tex.x, 1.0);
            }

            ENDCG
        }
    }
} 