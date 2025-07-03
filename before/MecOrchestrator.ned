//
//                  Simu5G
//
// Authors: Giovanni Nardini, Giovanni Stea, Antonio Virdis (University of Pisa)
//
// This file is part of a software released under the license included in file
// "license.pdf". Please read LICENSE and README files before using it.
// The above files and the present reference are part of the software itself,
// and cannot be removed from it.
//

package simu5g.nodes.mec.MECOrchestrator;

//
// This module models the functionalities of the MEC orchestrator within a Multi-access Edge
// Computing (MEC) system. Specifically, it manages the dynamic instantiation and
// termination of MEC applications on the MEC hosts belonging to the MEC system. Upon
// receiving a MEC app instantiation request from the ~UALCMP module, this module is
// responsible for selecting the MEC host on which the MEC application is to be instantiated, according
// to a configurable policy.
//
simple MecOrchestrator
{
    parameters:
        @display("i=device/mainframe;bgb=1006,692");

        @signal[TaskDelay_ms];
        @signal[SelectedHostLatency_ms];
        @signal[MecCpuLoad];
        @signal[RoundTripTime_ms];
        @signal[EnergyUsed_mJ];
        @signal[throughput];
        @signal[packetLoss];
        @signal[jitter];
        @signal[rtt];
        @signal[radioUtilization];
        @signal[cpuUtilization];

        @statistic[taskDelay](source=TaskDelay_ms; record=mean, histogram; unit=ms);
        @statistic[selectedLatency](source=SelectedHostLatency_ms; record=mean, histogram; unit=ms);
        @statistic[cpuLoad](source=MecCpuLoad; record=mean, histogram);
        @statistic[energy](source=EnergyUsed_mJ; record=mean, histogram);
        @statistic[throughput](source=throughput; record=mean, histogram; unit=bps);
		@statistic[packetLoss](source=packetLoss; record=count, histogram; unit=count);
		@statistic[jitter](source=jitter; record=mean, histogram; unit=ms);
		@statistic[rtt](source=rtt; record=mean, histogram; unit=ms);
		@statistic[radioUtilization](source=radioUtilization; record=mean, histogram; unit=percent);
		@statistic[cpuUtilization](source=cpuUtilization; record=mean, histogram; unit=percent);
		@statistic[cpuLoad](source=MecCpuLoad; record=mean, histogram; unit=percent);
		@statistic[energy](source=EnergyUsed_mJ; record=mean, histogram; unit=mJ);

        string binderModule = default("binder");
        string selectionPolicy @enum(MecHostBased,MecServiceBased,AvailableResourcesBased, LatencyBased) = default("MecServiceBased");
        double latencyHost1 @unit(s);
        double latencyHost2 @unit(s);
        int mecHostIndex = default(0);
        object mecHostList = default([]);
        object mecApplicationPackageList = default([]);

        double onboardingTime @unit(s) = default(50ms);
        double instantiationTime @unit(s) = default(50ms);
        double terminationTime @unit(s) = default(50ms);
    gates:
        output toUALCMP;
        input fromUALCMP;
}

