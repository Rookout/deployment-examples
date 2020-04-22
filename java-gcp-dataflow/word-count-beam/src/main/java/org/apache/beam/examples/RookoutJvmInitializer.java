package org.apache.beam.examples;

import com.rookout.rook.API;
import com.rookout.rook.RookOptions;
import org.apache.beam.sdk.harness.JvmInitializer;
import org.apache.beam.sdk.options.PipelineOptions;
import com.google.auto.service.AutoService;

@AutoService(JvmInitializer.class)
public class RookoutJvmInitializer implements JvmInitializer {
    @Override
    public void beforeProcessing(PipelineOptions options) {
        RookOptions opts = new RookOptions();
        opts.token = "c553623651e849837fea421627481a9da0f0cf7f12e218e531b46b4449d7bc91";
        API.start(opts);
    }
}