package org.apache.beam.examples;

import com.rookout.rook.API;
import com.rookout.rook.RookOptions;
import org.apache.beam.sdk.harness.JvmInitializer;
import org.apache.beam.sdk.options.PipelineOptions;
import com.google.auto.service.AutoService;
import java.util.HashMap;

@AutoService(JvmInitializer.class)
public class RookoutJvmInitializer implements JvmInitializer {
    @Override
    public void beforeProcessing(PipelineOptions options) {
        RookOptions opts = new RookOptions();
        opts.token = "<YOUR-TOKEN>";
        opts.labels = new HashMap<String, String>() {{
            put("env", "prod");
        }};
        API.start(opts);
    }
}