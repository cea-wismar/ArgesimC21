within ;
package ArgesimLib
  import Modelica.SIunits.*;
  import Modelica.Constants.pi;
  block ResetIntegrator "Integrator block with reset"
      import Modelica.Blocks.Interfaces.*;
      import Modelica.Blocks.Types.Init;
      parameter Init initType = Init.InitialState  "Type of initialization" annotation (
              Evaluate = true,
              Dialog(group = "Initialization"));
      parameter Real y_start = 0 "Initial or guess value of output (= state)"  annotation (Dialog(group = "Initialization"));
      RealInput u annotation (Placement(transformation(
              extent = {
                  {-140, -20},
                  {-100, 20}},
              rotation = 0)));
      RealInput y0 annotation (Placement(transformation(
              extent = {
                  {-140, -80},
                  {-100, -40}},
              rotation = 0), iconTransformation(extent={{-140,-90},{-100,-50}})));
      RealOutput y(start = y_start) annotation (Placement(transformation(
              extent = {
                  {100, -10},
                  {120, 10}},
              rotation = 0)));
      BooleanInput r "Reset switch"  annotation (Placement(transformation(
              origin = {0, 110},
              extent = {
                  {-10, -10},
                  {10, 10}},
              rotation = -90)));
  initial equation
      if initType == Init.SteadyState then
        der(y) = 0;
      elseif initType == Init.InitialState or initType == Init.InitialOutput then
        y = y_start;
      end if;
  equation
      when r then
        reinit(y, y0);
      end when;
      der(y) = u;

      annotation (
          Icon(
              coordinateSystem(
                  preserveAspectRatio = true,
                  extent = {
                      {-100, -100},
                      {100, 100}}),
              graphics={
                  Rectangle(
                      extent = {
                          {-100, -100},
                          {100, 100}},
                      lineColor = {0, 0, 127},
                      fillColor = {255, 255, 255},
                      fillPattern = FillPattern.Solid),
                  Text(
                      extent = {
                          {-150, 150},
                          {150, 110}},
                      textString = "%name",
                      lineColor = {0, 0, 255}),
                  Rectangle(
                      extent = {
                          {-100, -100},
                          {100, 100}},
                      lineColor = {0, 0, 127},
                      fillColor = {255, 255, 255},
                      fillPattern = FillPattern.Solid),
                  Line(
                      points = {
                          {-80, -90},
                          {-80, 90}},
                      color = {127, 127, 127}),
                  Polygon(
                      points = {
                          {-80, 90},
                          {-88, 68},
                          {-72, 68},
                          {-80, 90}},
                      color = {127, 127, 127},
                      fillColor = {127, 127, 127}),
                  Line(
                      points = {
                          {-90, -80},
                          {90, -80}},
                      color = {127, 127, 127}),
                  Polygon(
                      points = {
                          {90, -80},
                          {68, -88},
                          {68, -72},
                          {90, -80}},
                      color = {127, 127, 127},
                      fillColor = {127, 127, 127}),
                  Line(
                      points = {
                          {-80, -80},
                          {0, 0},
                          {0, -75},
                          {65, -75}},
                      color = {0, 0, 255}),
                  Text(
                      extent = {
                          {0, 0},
                          {80, 80}},
                      textString = "1/s"),
                  Text(
                      extent = {
                          {-150, -150},
                          {150, -110}},
                      textString = "%name",
                      lineColor = {0, 0, 255})}),
            Diagram(coordinateSystem(extent = {
              {-100, -100},
              {100, 100}})),
          Documentation(info = "<html><p>Integrator block with external reset</p></html>"));
  end ResetIntegrator;

  block NegZeroCrossing "Trigger negative zero crossing of input u"
    extends Modelica.Blocks.Interfaces.partialBooleanSO;
    Modelica.Blocks.Interfaces.RealInput u  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  protected
    Boolean u_neg;
  initial equation
    pre(u_neg) = false;
  equation
    u_neg = u <= 0;
    y = edge(u_neg);
    annotation (Documentation(info="<html>
<p>
The output \"y\" is <b>true</b> at the
time instant when the input \"u\" becomes
zero, provided the input \"enable\" is
<b>true</b>. At all other time instants, the output \"y\" is <b>false</b>.
If the input \"u\" is zero at a time instant when the \"enable\"
input changes its value, then the output y is <b>false</b>.
</p>
<p>
Note, that in the plot window of a Modelica simulator, the output of
this block is usually identically to <b>false</b>, because the output
may only be <b>true</b> at an event instant, but not during
continuous integration. In order to check that this component is
actually working as expected, one should connect its output to, e.g.,
component <i>ModelicaAdditions.Blocks.Discrete.TriggeredSampler</i>.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-78,68},{-78,-80}}, color={192,192,192}),
          Polygon(
            points={{-78,90},{-86,68},{-70,68},{-78,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,0},{70,0}}, color={192,192,192}),
          Line(points={{-78,0},{-73.2,32.3},{-70,50.3},{-66.7,64.5},{-63.5,74.2},
                {-60.3,79.3},{-57.1,79.6},{-53.9,75.3},{-50.7,67.1},{-46.6,52.2},
                {-41,25.8},{-33,-13.9},{-28.2,-33.7},{-24.1,-45.9},{-20.1,-53.2},
                {-16.1,-55.3},{-12.1,-52.5},{-8.1,-45.3},{-3.23,-32.1},{10.44,
                13.7},{15.3,26.4},{20.1,34.8},{24.1,38},{28.9,37.2},{33.8,31.8},
                {40.2,19.4},{53.1,-10.5},{59.5,-21.2},{65.1,-25.9},{70.7,-25.9},
                {77.2,-20.5},{82,-13.8}}, color={135,135,135}, smooth=Smooth.Bezier),
          Polygon(
            points={{92,0},{70,8},{70,-8},{92,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-36,-59},{-36,81}}, color={255,0,255}),
          Line(points={{49,-59},{49,81}}, color={255,0,255}),
          Line(points={{-78,0},{70,0}}, color={255,0,255})}));
  end NegZeroCrossing;

  model AirResistance "block version of air resistance"
    parameter Real k = 0.002 "Air resistance";
    Modelica.Blocks.Math.Gain gain1(k=k)
      annotation (Placement(transformation(extent={{-10,-28},{10,-8}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{42,-10},{62,10}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-48,-28},{-28,-8}})));
    Modelica.Blocks.Math.Sign sign1
      annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
    Modelica.Blocks.Interfaces.RealOutput Fr annotation (Placement(
          transformation(rotation=0, extent={{100,-10},{120,10}}),
          iconTransformation(extent={{92,-10},{112,10}})));
    Modelica.Blocks.Interfaces.RealInput v annotation (Placement(transformation(
            rotation=0, extent={{-120,-10},{-100,10}}), iconTransformation(
            extent={{-108,-10},{-88,10}})));
  equation
    connect(sign1.y,product. u1)
      annotation (Line(points={{-7,20},{20,20},{20,6},{40,6}},
                                                     color={0,0,127}));
    connect(gain1.u,product1. y)
      annotation (Line(points={{-12,-18},{-27,-18}}, color={0,0,127}));
    connect(gain1.y,product. u2) annotation (Line(points={{11,-18},{20,-18},{20,
            -6},{40,-6}},        color={0,0,127}));
    connect(Fr, product.y)
      annotation (Line(points={{110,0},{63,0}}, color={0,0,127}));
    connect(v, product1.u1) annotation (Line(points={{-110,0},{-64,0},{-64,-12},
            {-50,-12}}, color={0,0,127}));
    connect(v, product1.u2) annotation (Line(points={{-110,0},{-64,0},{-64,-24},
            {-50,-24}}, color={0,0,127}));
    connect(v, sign1.u) annotation (Line(points={{-110,0},{-64,0},{-64,20},{-30,
            20}}, color={0,0,127}));
    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,0}), Text(
            extent={{-102,54},{100,-40}},
            lineColor={0,0,0},
            textString="Air
Resistance")}));
  end AirResistance;

  model Gravity1d
    parameter Real g = 9.81;
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
    Modelica.Blocks.Sources.Constant const(k=-g)
      annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
        Placement(transformation(rotation=0, extent={{90,-10},{110,10}})));
  equation
    connect(const.y, force.f)
      annotation (Line(points={{-37,0},{-24,0}}, color={0,0,127}));
    connect(flange, force.flange)
      annotation (Line(points={{100,0},{-2,0}}, color={0,127,0}));
    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-84,78},{62,-60}},
            lineColor={28,108,200},
            textString="Gravity")}));
  end Gravity1d;

  model AirResistance1d "1d mechanics version of air resistance"
    parameter Real beta = 0.002;
    Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(extent={{-92,-2},{-72,18}})));
    Modelica.Blocks.Math.Gain gain(k=-beta)
      annotation (Placement(transformation(extent={{30,-4},{50,16}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{-8,-4},{12,16}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-50,-16},{-30,4}})));
    Modelica.Blocks.Math.Sign sign1
      annotation (Placement(transformation(extent={{-50,14},{-30,34}})));
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{62,-4},{82,16}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
        Placement(transformation(rotation=0, extent={{90,-10},{110,10}})));
  equation
    connect(speedSensor.v, sign1.u) annotation (Line(points={{-71,8},{-62,8},{-62,
            24},{-52,24}}, color={0,0,127}));
    connect(product1.u1, sign1.u) annotation (Line(points={{-52,0},{-62,0},{-62,
            24},{-52,24}}, color={0,0,127}));
    connect(product1.u2, sign1.u) annotation (Line(points={{-52,-12},{-62,-12},
            {-62,24},{-52,24}}, color={0,0,127}));
    connect(sign1.y, product.u1) annotation (Line(points={{-29,24},{-20,24},{-20,
            12},{-10,12}}, color={0,0,127}));
    connect(product1.y, product.u2) annotation (Line(points={{-29,-6},{-20,-6},
            {-20,0},{-10,0}}, color={0,0,127}));
    connect(product.y, gain.u)
      annotation (Line(points={{13,6},{28,6}}, color={0,0,127}));
    connect(gain.y, force.f)
      annotation (Line(points={{51,6},{60,6}}, color={0,0,127}));
    connect(flange, force.flange) annotation (Line(points={{100,0},{92,0},{92,6},
            {82,6}}, color={0,127,0}));
    connect(speedSensor.flange, force.flange) annotation (Line(points={{-92,8},
            {-96,8},{-96,-28},{92,-28},{92,6},{82,6}}, color={0,127,0}));
    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-102,54},{100,-40}},
            lineColor={28,108,200},
            textString="Air
Resistance")}));
  end AirResistance1d;

  model Hardstop1d "1D translational hardstop, with fall through"
    parameter Real mu = 0.9 "Coefficient of restitution";
    parameter StateSelect stateSelect = StateSelect.prefer "Priority to use s and v as states";
    Position s(stateSelect = stateSelect) "height";
    Velocity v(stateSelect = stateSelect) "velocity";
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (Placement(transformation(
            extent = {
                  {-110, -10},
                  {-90, 10}},
             rotation = 0)));

  equation
    s = flange_a.s;
    v = der(s);
    when s <= 0 then
      reinit(v, -mu*pre(v));
    end when;
    flange_a.f = 0;
    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-76,80},{76,-70}},
            lineColor={28,108,200},
            textString="Hardstop")}));
  end Hardstop1d;

  model Hardstop1dA "1D translational hardstop"
    parameter Real mu = 0.9 "coefficient of restitution";
    parameter Acceleration g = 9.81  "gravity constant";
    parameter Mass m = 1.0 "mass";
    parameter StateSelect stateSelect = StateSelect.prefer "Priority to use s and v as states";
    Position s(stateSelect = stateSelect) "height";
    Velocity v(stateSelect = stateSelect) "velocity";
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (Placement(transformation(
            extent = {
                  {-110, -10},
                  {-90, 10}},
             rotation = 0)));
    Boolean flying;

  equation
    flying = not (s <= 0 and v <= 0);
    s = flange_a.s;
    v = der(s);
    flange_a.f = if flying then 0 else -m*g;

    when s <= 0 then
      reinit(v, -mu*pre(v));
    end when;

    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-76,80},{76,-70}},
            lineColor={28,108,200},
            textString="Hardstop")}));
  end Hardstop1dA;

  model Hardstop1dB "1D translational hardstop, with bounce time logging"
    parameter Real mu = 0.9 "coefficient of restitution";
    parameter Acceleration g = 9.81  "gravity constant";
    parameter Mass m = 1.0 "mass";
    parameter StateSelect stateSelect = StateSelect.prefer "Priority to use s and v as states";
    Position s(stateSelect = stateSelect) "height";
    Velocity v(stateSelect = stateSelect) "velocity";
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (Placement(transformation(
            extent = {
                  {-110, -10},
                  {-90, 10}},
             rotation = 0)));
    Boolean flying;
    Real tbounce;
    Integer bounce( start = 0);

  equation
    flying = not (s <= 0 and v <= 0);
    s = flange_a.s;
    v = der(s);
    flange_a.f = if flying then 0 else -m*g;

    when s <= 0 then
      reinit(v, -mu*pre(v));
      bounce = pre(bounce) +1;
      tbounce = time;
      Modelica.Utilities.Streams.print(String(time, significantDigits=16));
    end when;

    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-76,80},{76,-70}},
            lineColor={28,108,200},
            textString="Hardstop")}));
  end Hardstop1dB;

  model Hardstop1dC "1D translational hardstop with explicit bounce stop"
    parameter Real mu = 0.9 "Coefficient of restitution";
    parameter Real g = 9.81  "Gravity constant";
    parameter StateSelect stateSelect = StateSelect.prefer "Priority to use s and v as states";
    parameter Real stopHeight(start = 0.00001);
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (Placement(transformation(
            extent = {
                  {-110, -10},
                  {-90, 10}},
             rotation = 0)));
    Position s(stateSelect = stateSelect) "height";
    Velocity v(stateSelect = stateSelect) "velocity";
    Boolean isFalling;
    Boolean isAtTop;

  equation
    s = flange_a.s;
    v = der(s);
    isFalling = v < 0;  // isFalling = sign(v) < 0; // => bug!
    isAtTop = edge(isFalling);

    when isAtTop and s <= stopHeight then
      reinit(s, 0);
      reinit(v, 0);   // necessary, otherwise v = -eps -> falls through
      flange_a.f = -g;
    elsewhen s <= 0 then
      reinit(v, -mu*pre(v));
      flange_a.f = 0;
    end when;
    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-76,80},{76,-70}},
            lineColor={28,108,200},
            textString="Hardstop")}));
  end Hardstop1dC;

  model ElastoGap "ElastoGap with internal w state"
    import Modelica.Mechanics.Translational.Interfaces.*;
    parameter TranslationalSpringConstant c = 1e6 "Spring constant";
    parameter TranslationalDampingConstant d = 500 "Damping constant";
    Flange_a flange_a annotation (Placement(transformation(
              extent = {
                  {-110, -10},
                  {-90, 10}},
              rotation = 0)));
    Flange_b flange_b annotation (Placement(transformation(
              extent = {
                  {90, -10},
                  {110, 10}},
              rotation = 0)));

    Position s_rel(start = 0) "Relative distance (= flange_b.s - flange_a.s)";
    Velocity v_rel(start = 0) "Relative velocity (= der(s_rel))";
    Position w(start = 0, fixed=true) "deformation of the spring";

    Boolean hasContact(start=false);
    Boolean flyRestarted(start=false);
    Force fc;
    Position y;
  equation
    fc = if hasContact then -c*s_rel - d*v_rel else 0;
    y = s_rel + w;
    hasContact = (y <= 0);
    flyRestarted = (fc <= 0);
    s_rel = flange_b.s - flange_a.s;
    v_rel = der(s_rel);
    der(w) = if (hasContact and not flyRestarted) then -v_rel else -(c/d)*w;
    flange_a.f = fc;
    flange_b.f = -fc;

    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-108,58},{104,-50}},
            lineColor={28,108,200},
            textString="Elasto
Gap")}));
  end ElastoGap;

  model ElastoGapA
    "ElastoGap with internal w state and additional output functions"
    import Modelica.Mechanics.Translational.Interfaces.*;
    parameter TranslationalSpringConstant c = 1e6 "Spring constant";
    parameter TranslationalDampingConstant d = 500 "Damping constant";
    Flange_a flange_a annotation (Placement(transformation(
              extent = {
                  {-110, -10},
                  {-90, 10}},
              rotation = 0)));
    Flange_b flange_b annotation (Placement(transformation(
              extent = {
                  {90, -10},
                  {110, 10}},
              rotation = 0)));

    Position s_rel(start = 0) "Relative distance (= flange_b.s - flange_a.s)";
    Velocity v_rel(start = 0) "Relative velocity (= der(s_rel))";
    Position w(start = 0, fixed=true) "deformation of the spring";

    Boolean hasContact(start=false);
    Boolean flyRestarted(start=false);
    Force fc;
    Position y;

    Boolean isFalling, isRising, isAtTop, isAtBottom;
    Position hMax, wMax;
    Integer countH, countW;

  equation
    fc = if hasContact then -c*s_rel - d*v_rel else 0;
    y = s_rel + w;
    hasContact = (y <= 0);
    flyRestarted = (fc <= 0);
    s_rel = flange_b.s - flange_a.s;
    v_rel = der(s_rel);
    der(w) = if (hasContact and not flyRestarted) then -v_rel else -(c/d)*w;
    flange_a.f = fc;
    flange_b.f = -fc;

    isFalling = v_rel < 0;
    isRising = not isFalling;
    isAtBottom = edge(isRising);
    isAtTop = edge(isFalling);

  algorithm
    when isAtTop then
      hMax := s_rel;
      countH := pre(countH) +1;
    elsewhen isAtBottom then
      wMax := w;
      countW := pre(countW) +1;
    end when;

    annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}), Text(
            extent={{-108,58},{104,-50}},
            lineColor={28,108,200},
            textString="Elasto
Gap")}));
  end ElastoGapA;

  model DIsc1 "short-cut diode after Fritzson 2015, p.56"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    Real s;
    Boolean off;
  equation
    off = s < 0;
    v = if off then s else 0;
    i = if off then 0 else s;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,0}),
          Line(points={{40,60},{40,-60}}, color={0,0,0})}),        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIsc1;

  model DIshu1 "diode model after Shockley"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real IS = 1e-8;
    parameter Real UT = 26e-3;
  equation
    i = if v < 0 then 0 else IS*(exp(v/UT)-1);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{40,60},{40,-60}}, color={0,0,255}),
          Text(
            extent={{-24,-52},{24,-98}},
            lineColor={0,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.None,
            textString="U")}),                                     Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIshu1;

  model DIshi1 "diode model after Shockley"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real IS = 1e-8;
    parameter Real UT = 26e-3;
  equation
    if v < 0 then
      i = 0;
    else
      v = UT*log(i/IS+1);
    end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{40,60},{40,-60}}, color={0,0,255}),
          Text(
            extent={{-24,-52},{24,-98}},
            lineColor={0,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.None,
            textString="I")}),                                     Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIshi1;

  model LookupTableDiode "interpolation table for approximated shockley"
    parameter Voltage uMax = 3.84e-2 "last breakpoint of interpolation";
    parameter Integer N = 10 "number of breakpoints for interpolation";
    parameter Current IS = 1e-8;
    parameter Voltage UT = 26e-3;

    Real up[N] = linspace(0, uMax, N);
    Real ip[N] = IS*(exp(up/UT) - ones(N));

    Modelica.Blocks.Interfaces.RealInput u  annotation (Placement(transformation(
        origin = {-120, 0},
        extent = {
            {-20, -20},
            {20, 20}},
        rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y  annotation (Placement(transformation(
        origin = {110, 0},
        extent = {
            {-10, -10},
            {10, 10}},
        rotation = 0)));

  equation
    y = Utilities.linInterp(u, up, ip);

    annotation (
        __Maplesoft_Component(
            helpTopic = "signalBlocks,interpolationTables,1DLookupTable",
            parameters = {
                Param(
                    name = "datasourcemode",
                    display = "data source"),
                Param(
                    name = "skiprows",
                    display = "skip rows")},
            visible = true),
        Diagram(
            coordinateSystem(extent = {
                {-100, -100},
                {100, 100}}),
            graphics={
                Rectangle(
                    extent = {
                        {-60, 60},
                        {60, -60}},
                    fillColor = {235, 235, 235},
                    fillPattern = FillPattern.Solid,
                    lineColor = {0, 0, 255}),
                Line(
                    points = {
                        {-100, 0},
                        {-58, 0}},
                    color = {0, 0, 255}),
                Line(
                    points = {
                        {60, 0},
                        {100, 0}},
                    color = {0, 0, 255}),
                Text(
                    extent = {
                        {-100, 100},
                        {100, 64}},
                    textString = "1 dimensional table interpolation",
                    lineColor = {0, 0, 255}),
                Line(
                    points = {
                        {-54, 40},
                        {-54, -40},
                        {54, -40},
                        {54, 40},
                        {28, 40},
                        {28, -40},
                        {-28, -40},
                        {-28, 40},
                        {-54, 40},
                        {-54, 20},
                        {54, 20},
                        {54, 0},
                        {-54, 0},
                        {-54, -20},
                        {54, -20},
                        {54, -40},
                        {-54, -40},
                        {-54, 40},
                        {54, 40},
                        {54, -40}},
                    color = {0, 0, 0}),
                Line(
                    points = {
                        {0, 40},
                        {0, -40}},
                    color = {0, 0, 0}),
                Rectangle(
                    extent = {
                        {-54, 40},
                        {-28, 20}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 255, 0},
                    fillPattern = FillPattern.Solid),
                Rectangle(
                    extent = {
                        {-54, 20},
                        {-28, 0}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 255, 0},
                    fillPattern = FillPattern.Solid),
                Rectangle(
                    extent = {
                        {-54, 0},
                        {-28, -20}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 255, 0},
                    fillPattern = FillPattern.Solid),
                Rectangle(
                    extent = {
                        {-54, -20},
                        {-28, -40}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 255, 0},
                    fillPattern = FillPattern.Solid),
                Text(
                    extent = {
                        {-52, 56},
                        {-34, 44}},
                    textString = "u",
                    lineColor = {0, 0, 255}),
                Text(
                    extent = {
                        {-22, 54},
                        {2, 42}},
                    textString = "y[1]",
                    lineColor = {0, 0, 255}),
                Text(
                    extent = {
                        {4, 54},
                        {28, 42}},
                    textString = "y[2]",
                    lineColor = {0, 0, 255}),
                Text(
                    extent = {
                        {0, -40},
                        {32, -54}},
                    textString = "columns",
                    lineColor = {0, 0, 255})}),
        Icon(
            coordinateSystem(extent = {
                {-100, -100},
                {100, 100}}),
            graphics={
                Rectangle(
                    extent = {
                        {-100, -100},
                        {100, 100}},
                    lineColor = {0, 0, 127},
                    fillColor = {255, 255, 255},
                    fillPattern = FillPattern.Solid),
                Line(
                    points = {
                        {-60, 40},
                        {-60, -40},
                        {60, -40},
                        {60, 40},
                        {30, 40},
                        {30, -40},
                        {-30, -40},
                        {-30, 40},
                        {-60, 40},
                        {-60, 20},
                        {60, 20},
                        {60, 0},
                        {-60, 0},
                        {-60, -20},
                        {60, -20},
                        {60, -40},
                        {-60, -40},
                        {-60, 40},
                        {60, 40},
                        {60, -40}},
                    color = {0, 0, 0}),
                Line(
                    points = {
                        {0, 40},
                        {0, -40}},
                    color = {0, 0, 0}),
                Rectangle(
                    extent = {
                        {-60, 40},
                        {-30, 20}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 204, 51},
                    fillPattern = FillPattern.Solid),
                Rectangle(
                    extent = {
                        {-60, 20},
                        {-30, 0}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 204, 51},
                    fillPattern = FillPattern.Solid),
                Rectangle(
                    extent = {
                        {-60, 0},
                        {-30, -20}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 204, 51},
                    fillPattern = FillPattern.Solid),
                Rectangle(
                    extent = {
                        {-60, -20},
                        {-30, -40}},
                    lineColor = {0, 0, 0},
                    fillColor = {255, 204, 51},
                    fillPattern = FillPattern.Solid),
                Text(
                    extent = {
                        {-150, 150},
                        {150, 110}},
                    textString = "%name",
                    lineColor = {0, 0, 255})}));
  end LookupTableDiode;

  model DIas1 "interpolated Shockley diode model"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Voltage uMax = 3.84e-2 "last breakpoint of interpolation";
    parameter Integer N = 10 "number of breakpoints for interpolation";
    parameter Real IS = 1e-8;
    parameter Real UT = 26e-3;

    Real up[N] = linspace(0, uMax, N);
    Real ip[N] = IS*(exp(up/UT) - ones(N));
    Boolean off;

  equation
    off = v < 0;
    i = if off then 0 else Utilities.linInterp(v, up, ip);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{40,60},{40,-60}}, color={0,0,255}),
          Line(points={{-100,0},{-40,0}}, color={0,0,255}),
          Line(points={{40,0},{98,0}}, color={0,0,255}),
          Text(
            extent={{-76,-66},{48,-92}},
            lineColor={0,0,0},
            textString="N = %N")}),                                Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIas1;

  model DiodeExternal "Diode with external input of characteristic curve"
    import Modelica.Blocks.Interfaces.*;
    import Modelica.Blocks.Types.Init;
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    RealInput id annotation (Placement(transformation(
              extent = {
                  {-140, -80},
                  {-100, -40}},
              rotation = 0), iconTransformation(extent={{-120,-90},{-80,-50}})));
    Boolean off;
  equation
    off = v < 0;
    if off then
      i = 0;
    else i = id;
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{40,60},{40,-60}}, color={0,0,255}),
          Line(points={{-90,-70},{0,-70},{0,-30}}, color={0,0,0}),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DiodeExternal;

  model DIas2 "Approximated Shockley diode, block version"
    parameter Voltage UMax = 0.0384;
    parameter Integer N = 10;
    parameter Current IS = 1e-8;
    parameter Voltage UT = 0.026;

    Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (Placement(
          transformation(
          origin={200,100},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (Placement(
          transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    ArgesimLib.DiodeExternal DiExt annotation (Placement(transformation(
          origin={110,170},
          extent={{-20,-20},{20,20}},
          rotation=0)));
    ArgesimLib.LookupTableDiode LTD1(uMax = UMax, N = N, IS = IS, UT = UT) annotation (Placement(transformation(
          origin = {110, 110},
          extent = {
              {-20, -20},
              {20, 20}},
          rotation = -180)));

    Modelica.Electrical.Analog.Sensors.VoltageSensor VS1  annotation (Placement(transformation(extent={{96,62},
              {116,42}})));
  equation
    connect(DiExt.n, n) annotation (Line(
        points={{130,170},{180,170},{180,100},{200,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(LTD1.y,DiExt.id) annotation (Line(
          points={{88,110},{70,110},{70,156},{90,156}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(VS1.n, n) annotation (Line(
        points={{116,52},{180,52},{180,100},{200,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(VS1.p, p) annotation (Line(
        points={{96,52},{20,52},{20,100},{0,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(VS1.p,DiExt.p) annotation (Line(
          points={{96,52},{20,52},{20,170},{90,170}},
          color = {0, 0, 255},
          smooth = Smooth.None));
    connect(VS1.v, LTD1.u) annotation (Line(points={{106,62},{106,74},{156,74},
            {156,110},{134,110}}, color={0,0,127}));
    annotation (
          Diagram(
              coordinateSystem(
                  preserveAspectRatio = true,
                  extent = {
                      {0, 0},
                      {200, 200}})),
          Icon(
              coordinateSystem(
                  preserveAspectRatio = true,
                  extent = {
                      {0, 0},
                      {200, 200}}),
              graphics={
          Polygon(points={{142,100},{62,160},{62,40},{142,100}},
                                                             lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{142,160},{142,40}},
                                          color={0,0,255}),
          Line(points={{2,100},{62,100}}, color={0,0,255}),
          Line(points={{142,100},{200,100}},
                                       color={0,0,255}),
          Text(
            extent={{26,34},{150,8}},
            lineColor={0,0,0},
            textString="N = %N")}));
  end DIas2;

  model DIesu1 "explicit Shockley, deriative of shockley function"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real Is = 1e-8;
    parameter Real UT = 26e-3;
    Boolean off;
  initial equation
    i = 0;
  equation
    off = v < 0;
    if off then
      i = 0;
    else
      der(i) = (Is/UT)*exp(v/UT)*der(v);
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,0}),
          Line(points={{40,60},{40,-60}}, color={0,0,0})}),        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIesu1;

  model DIesu2 "explicit Shockley, deriative of shockley function"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real Is = 1e-8;
    parameter Real UT = 26e-3;
    Boolean off;
  initial equation
    i = 0;
  equation
    off = v < 0;
    if off then
      der(i) = 0;
    else
      der(i) = (Is/UT)*exp(v/UT)*der(v);
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,0}),
          Line(points={{40,60},{40,-60}}, color={0,0,0})}),        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIesu2;

  model DIesi1 "explicit Shockley, deriative of shockley function"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real Is = 1e-8;
    parameter Real UT = 26e-3;
    Boolean off;
  initial equation
    i = 0;
  equation
    off = v < 0;
    if off then
      i = 0;
    else
      der(v) = (UT/Is)/(i/Is + 1)*der(i);
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,0}),
          Line(points={{40,60},{40,-60}}, color={0,0,0})}),        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIesi1;

  model DIesi2 "explicit Shockley, deriative of shockley function"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real Is = 1e-8;
    parameter Real UT = 26e-3;
    Boolean off;
  initial equation
    i = 0;
  equation
    off = v < 0;
    if off then
      der(i) = 0;
    else
      der(v) = (UT/Is)/(i/Is + 1)*der(i);
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(points={{-98,0},{92,0}}, color={0,0,255}),
          Polygon(points={{40,0},{-40,60},{-40,-60},{40,0}}, lineColor={0,0,0}),
          Line(points={{40,60},{40,-60}}, color={0,0,0})}),        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DIesi2;

  model Rope
    parameter Length l = 1 "Length of vector r";
    parameter Force Fbrake = 10000 "holding force of break";
    Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(
      useAxisFlange=true,
      n={0,1,0},
      s(start=l, fixed=true),
      v(start=0, fixed=true))
                 annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={60,26})));
    Modelica.Mechanics.Translational.Components.Rod rod(L=l) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={6,28})));
    Modelica.Mechanics.Translational.Components.Brake brake(
      useSupport=true,
      peak=1,
      cgeo=1,
      fn_max=Fbrake)
                   annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={6,0})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{-36,-8},{-20,8}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-64,-8},{-48,8}})));
    Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={6,62})));
    Modelica.Blocks.Interfaces.RealOutput f(unit="N") annotation (Placement(
          transformation(rotation=0, extent={{-98,70},{-118,90}}),
          iconTransformation(extent={{-92,50},{-112,70}})));
    Modelica.Blocks.Interfaces.BooleanInput isFalling annotation (Placement(
          transformation(rotation=0, extent={{-114,-10},{-94,10}}),
          iconTransformation(extent={{-108,-90},{-88,-70}})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation (Placement(
          transformation(
          rotation=90,
          extent={{-10,-10},{10,10}},
          origin={60,100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,100})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={60,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-100})));
    Modelica.Blocks.Interfaces.RealOutput s annotation (Placement(transformation(
            rotation=0, extent={{-98,30},{-118,50}}), iconTransformation(extent={{
              -92,10},{-112,30}})));
    Modelica.Mechanics.Translational.Sensors.RelPositionSensor relPositionSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={30,46})));
    Modelica.Blocks.Math.Add add(k1=-1)
      annotation (Placement(transformation(extent={{-68,30},{-88,50}})));
    Modelica.Blocks.Sources.Constant const(k=l)
      annotation (Placement(transformation(extent={{-22,20},{-42,40}})));
  equation
    connect(brake.flange_a,rod. flange_b) annotation (Line(points={{6,10},{6,18}},
                                         color={0,127,0}));
    connect(brake.support,prismatic. axis)
      annotation (Line(points={{16,-1.77636e-15},{16,18},{54,18}},
                                                      color={0,127,0}));
    connect(booleanToReal.y,brake. f_normalized) annotation (Line(points={{-19.2,0},
            {-11.65,0},{-11.65,1.9984e-15},{-5,1.9984e-15}},
                                            color={0,0,127}));
    connect(not1.y, booleanToReal.u)
      annotation (Line(points={{-47.2,0},{-37.6,0}}, color={255,0,255}));
    connect(forceSensor.flange_b, prismatic.support) annotation (Line(points={{6,72},
            {6,76},{46,76},{46,30},{54,30}}, color={0,127,0}));
    connect(forceSensor.flange_a, rod.flange_a)
      annotation (Line(points={{6,52},{6,38}}, color={0,127,0}));
    connect(f, forceSensor.f) annotation (Line(points={{-108,80},{-60,80},{-60,54},
            {-5,54}}, color={0,0,127}));
    connect(frame_a, prismatic.frame_a)
      annotation (Line(points={{60,100},{60,36}}, color={95,95,95}));
    connect(frame_b, prismatic.frame_b)
      annotation (Line(points={{60,-100},{60,16}}, color={95,95,95}));
    connect(isFalling, not1.u)
      annotation (Line(points={{-104,0},{-65.6,0}}, color={255,0,255}));
    connect(relPositionSensor.flange_a, prismatic.support) annotation (Line(
          points={{30,56},{30,76},{46,76},{46,30},{54,30}}, color={0,127,0}));
    connect(relPositionSensor.flange_b, prismatic.axis)
      annotation (Line(points={{30,36},{30,18},{54,18}}, color={0,127,0}));
    connect(s, add.y)
      annotation (Line(points={{-108,40},{-89,40}}, color={0,0,127}));
    connect(add.u1, relPositionSensor.s_rel)
      annotation (Line(points={{-66,46},{19,46}}, color={0,0,127}));
    connect(const.y, add.u2) annotation (Line(points={{-43,30},{-54,30},{-54,34},{
            -66,34}}, color={0,0,127}));
    annotation (Icon(graphics={
          Ellipse(
            extent={{-18,-64},{18,-98}},
            lineColor={0,0,0},
            lineThickness=1),
          Line(
            points={{12,-60}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-96,-80},{-18,-80}},
            color={217,67,180},
            thickness=0.5),
          Text(
            extent={{-80,80},{-66,46}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="F"),
          Text(
            extent={{-82,42},{-68,8}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="s"),
          Rectangle(
            extent={{-2,98},{2,-64}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}));
  end Rope;

  model RPTrigger
    Modelica.Blocks.Logical.GreaterEqualThreshold fTrigger
      annotation (Placement(transformation(extent={{-54,-4},{-40,10}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold sTrigger
      annotation (Placement(transformation(extent={{-54,-30},{-40,-16}})));
    Modelica.Blocks.Logical.FallingEdge fallingEdgeS
      annotation (Placement(transformation(extent={{-32,-30},{-16,-14}})));
    Modelica.Blocks.Logical.FallingEdge fallingEdgeF
      annotation (Placement(transformation(extent={{-32,-6},{-16,10}})));
    Modelica.Blocks.Interfaces.RealInput F annotation (Placement(transformation(
            rotation=0, extent={{-114,50},{-94,70}}), iconTransformation(extent=
             {{-110,-70},{-90,-50}})));
    Modelica.Blocks.Interfaces.RealInput s annotation (Placement(transformation(
            rotation=0, extent={{-114,-70},{-94,-50}}), iconTransformation(
            extent={{-110,50},{-90,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput isFalling annotation (Placement(
          transformation(rotation=0, extent={{96,-10},{116,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{6,-18},{26,2}})));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant
      annotation (Placement(transformation(extent={{6,18},{26,38}})));
    JKFlipflop jKFlipflop
      annotation (Placement(transformation(extent={{48,-18},{68,2}})));
  equation
    connect(sTrigger.y, fallingEdgeS.u) annotation (Line(points={{-39.3,-23},{
            -34.65,-23},{-34.65,-22},{-33.6,-22}}, color={255,0,255}));
    connect(fTrigger.y, fallingEdgeF.u) annotation (Line(points={{-39.3,3},{
            -35.65,3},{-35.65,2},{-33.6,2}}, color={255,0,255}));
    connect(s, sTrigger.u) annotation (Line(points={{-104,-60},{-70,-60},{-70,
            -23},{-55.4,-23}}, color={0,0,127}));
    connect(F, fTrigger.u) annotation (Line(points={{-104,60},{-68,60},{-68,3},
            {-55.4,3}}, color={0,0,127}));
    connect(fallingEdgeF.y, or1.u1) annotation (Line(points={{-15.2,2},{-10,2},
            {-10,-8},{4,-8}}, color={255,0,255}));
    connect(fallingEdgeS.y, or1.u2) annotation (Line(points={{-15.2,-22},{-10,
            -22},{-10,-16},{4,-16}}, color={255,0,255}));
    connect(or1.y, jKFlipflop.CLK)
      annotation (Line(points={{27,-8},{47,-8}}, color={255,0,255}));
    connect(jKFlipflop.Q, isFalling)
      annotation (Line(points={{69,0},{106,0}}, color={255,0,255}));
    connect(booleanConstant.y, jKFlipflop.K) annotation (Line(points={{27,28},{
            36,28},{36,-16},{47,-16}}, color={255,0,255}));
    connect(jKFlipflop.J, jKFlipflop.K) annotation (Line(points={{47,0},{36,0},
            {36,-16},{47,-16}}, color={255,0,255}));
    annotation (Icon(graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
                                       Text(
            extent={{-88,62},{90,-44}},
            lineColor={28,108,200},
            textString="RP
Trigger"),Text(
            extent={{-82,-42},{-68,-76}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="F"),
          Text(
            extent={{-80,82},{-66,48}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="s")}));
  end RPTrigger;

  block JKFlipflop
    parameter Boolean Q0=false "Initial value";

    Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop(Qini=Q0)
      annotation (Placement(transformation(extent={{42,-10},{62,10}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-2,14},{18,34}})));
    Modelica.Blocks.Logical.And and2
      annotation (Placement(transformation(extent={{0,-34},{20,-14}})));
    Modelica.Blocks.Interfaces.BooleanInput J annotation (Placement(
          transformation(rotation=0, extent={{-120,70},{-100,90}}),
          iconTransformation(extent={{-120,70},{-100,90}})));
    Modelica.Blocks.Interfaces.BooleanInput CLK annotation (Placement(
          transformation(rotation=0, extent={{-120,-10},{-100,10}}),
          iconTransformation(extent={{-120,-10},{-100,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput Q annotation (Placement(
          transformation(rotation=0, extent={{100,70},{120,90}}),
          iconTransformation(extent={{100,70},{120,90}})));
    Modelica.Blocks.Interfaces.BooleanOutput QI annotation (Placement(
          transformation(rotation=0, extent={{100,-90},{120,-70}}),
          iconTransformation(extent={{100,-90},{120,-70}})));
    Modelica.Blocks.Logical.FallingEdge fallingEdge
      annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
    Modelica.Blocks.Logical.Pre pre1
      annotation (Placement(transformation(extent={{-30,18},{-18,30}})));
    Modelica.Blocks.Logical.Pre pre2
      annotation (Placement(transformation(extent={{-30,-38},{-18,-26}})));
    Modelica.Blocks.Logical.And and3
      annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
    Modelica.Blocks.Logical.And and4
      annotation (Placement(transformation(extent={{-64,-50},{-44,-30}})));
    Modelica.Blocks.Interfaces.BooleanInput K
      annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  equation
    connect(and2.u1,and1. u2) annotation (Line(
        points={{-2,-24},{-14,-24},{-14,16},{-4,16}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and1.y,rSFlipFlop. S) annotation (Line(
        points={{19,24},{34,24},{34,6},{40,6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and2.y,rSFlipFlop. R) annotation (Line(
        points={{21,-24},{34,-24},{34,-6},{40,-6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Q, rSFlipFlop.Q) annotation (Line(points={{110,80},{88,80},{88,6},{63,
            6}}, color={255,0,255}));
    connect(QI, rSFlipFlop.QI) annotation (Line(points={{110,-80},{88,-80},{88,-6},
            {63,-6}}, color={255,0,255}));
    connect(fallingEdge.u, CLK) annotation (Line(
        points={{-88,0},{-110,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(fallingEdge.y, and1.u2) annotation (Line(
        points={{-65,0},{-14,0},{-14,16},{-4,16}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pre1.y, and1.u1) annotation (Line(
        points={{-17.4,24},{-4,24}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(J, and3.u2) annotation (Line(
        points={{-110,80},{-90,80},{-90,32},{-66,32}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and3.u1, rSFlipFlop.QI) annotation (Line(
        points={{-66,40},{-72,40},{-72,56},{72,56},{72,-6},{63,-6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and3.y, pre1.u) annotation (Line(
        points={{-43,40},{-36,40},{-36,24},{-31.2,24}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pre2.y, and2.u2) annotation (Line(
        points={{-17.4,-32},{-2,-32}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and4.y, pre2.u) annotation (Line(
        points={{-43,-40},{-38,-40},{-38,-32},{-31.2,-32}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(K, and4.u1) annotation (Line(
        points={{-110,-80},{-90,-80},{-90,-40},{-66,-40}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and4.u2, rSFlipFlop.Q) annotation (Line(
        points={{-66,-48},{-72,-48},{-72,-58},{80,-58},{80,6},{63,6}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation ( Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}},
        initialScale=0.1),
        graphics={
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={223,211,169},
          lineThickness=5.0,
          borderPattern=BorderPattern.Raised,
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-20},{-70,0},{-100,20}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
      Line(
        points={{-70.0,-100.0},{-70.0,100.0}},
        color={0,0,127}),
      Line(
        points={{70.0,-100.0},{70.0,100.0}},
        color={0,0,127}),
      Rectangle(
          extent={{70,-95},{95,0}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
     Text(
        lineColor={0,0,127},
        extent={{-90.0,30.0},{90.0,90.0}},
        textString="JK")}),
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})));
  end JKFlipflop;

  model Revolute2D
    parameter Position radius=0.05 "Radius of animation cylinder";
    parameter Position length=0.1 "Length of animation cylinder";
    parameter RotationalDampingConstant b=1 "Rotational damping";
    parameter Angle theta0=0 "Initial angle of the revolute";
    parameter AngularVelocity om0=0 "Initial angular velocity of the revolute";
    PlanarMechanics.Interfaces.Frame_a frame_a annotation (Placement(
          transformation(extent={{-116,-16},{-84,16}}), iconTransformation(extent=
             {{-116,-16},{-84,16}})));
    PlanarMechanics.Interfaces.Frame_b frame_b annotation (Placement(
          transformation(extent={{84,-16},{116,16}}), iconTransformation(extent={{
              84,-16},{116,16}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
        Placement(transformation(extent={{-70,90},{-50,110}}), iconTransformation(
            extent={{-70,90},{-50,110}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
        Placement(transformation(extent={{50,90},{70,110}}), iconTransformation(
            extent={{50,90},{70,110}})));
    PlanarMechanics.Joints.Revolute revolute(useFlange=true,
      phi(fixed=true, start=theta0),
      cylinderLength=length,
      cylinderDiameter=radius*2,
      cylinderColor={0,128,255},
      w(fixed=true, start=om0)) annotation (Placement(transformation(extent={{10,10},
              {-10,-10}})));
    Modelica.Mechanics.Rotational.Components.Damper damper1(d = b) annotation (
          Placement(visible = true, transformation(origin = {-1.1396,35.6125},
              extent={{12,-12}, {-12,12}},                                                                                                                                                         rotation = 0)));
    Angle phi;
  equation
    connect(revolute.support, damper1.flange_a) annotation (Line(points={{6,10},{6,
            20},{10.8604,20},{10.8604,35.6125}},      color={0,0,0}));
    connect(revolute.flange_a, damper1.flange_b) annotation (Line(points={{0,10},{
            -13.1396,10},{-13.1396,35.6125}}, color={0,0,0}));
    connect(revolute.frame_b, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_a, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(flange_a, damper1.flange_a) annotation (Line(points={{-60,100},{-60,80},
            {10.8604,80},{10.8604,35.6125}}, color={0,0,0}));
    connect(flange_b, damper1.flange_b) annotation (Line(points={{60,100},{60,60},
            {-13.1396,60},{-13.1396,35.6125}}, color={0,0,0}));
    connect(flange_a, flange_a) annotation (Line(points={{-60,100},{-100,100},{-100,
            100},{-60,100}}, color={0,0,0}));
    phi = pi/2 - revolute.phi;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            fillColor={40,118,192},
            fillPattern=FillPattern.Solid,
            points={{43,-20},{83,-52},{69,-73},{29,-41},{43,-20}}),
          Ellipse(
            fillColor={40,118,192},
            fillPattern=FillPattern.Solid,
            extent={{-50,-50},{50,50}},
            endAngle=360),
          Ellipse(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-30,-30},{30,30}},
            endAngle=360),
          Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-91,-14},{-20,12}}),
          Rectangle(
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-32,-14},{7,12}}),
          Line(points={{3,77},{17,75},{30,70},{42,63},{50,56},{59,45},{66,34},{
                72,21}}),
          Polygon(fillPattern=FillPattern.Solid, points={{64,20},{79,22},{75,-2},
                {64,20}}),
          Rectangle(extent={{-100,-100},{100,100}})}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end Revolute2D;

  model Rope2D
    parameter Length l = 1 "Length of vector r";
    parameter Force Fbrake = 10000 "holding force of break";
    Modelica.Mechanics.Translational.Components.Rod rod(L=l) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={8,-12})));
    Modelica.Mechanics.Translational.Components.Brake brake(
      useSupport=true,
      peak=1,
      cgeo=1,
      fn_max=Fbrake)
                   annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={8,-40})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{-26,-48},{-10,-32}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-50,-48},{-34,-32}})));
    Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={8,22})));
    Modelica.Blocks.Interfaces.RealOutput f(unit="N") annotation (Placement(
          transformation(rotation=0, extent={{-66,16},{-86,36}}),
          iconTransformation(extent={{-92,50},{-112,70}})));
    Modelica.Blocks.Interfaces.BooleanInput isFalling annotation (Placement(
          transformation(rotation=0, extent={{-82,-50},{-62,-30}}),
          iconTransformation(extent={{-108,-90},{-88,-70}})));
    Modelica.Blocks.Interfaces.RealOutput s annotation (Placement(transformation(
            rotation=0, extent={{-64,-10},{-84,10}}), iconTransformation(extent={{
              -92,10},{-112,30}})));
    Modelica.Mechanics.Translational.Sensors.RelPositionSensor relPositionSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={32,6})));
    Modelica.Blocks.Math.Add add(k1=-1)
      annotation (Placement(transformation(extent={{-34,-10},{-54,10}})));
    Modelica.Blocks.Sources.Constant const(k=l)
      annotation (Placement(transformation(extent={{-6,-14},{-22,2}})));
    PlanarMechanics.Joints.Prismatic prismatic1(
      useFlange=true,
      r={0,1},
      s(start=l, fixed=true),
      v(start=0, fixed=true)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={60,24})));
    PlanarMechanics.Interfaces.Frame_a frame_a annotation (Placement(
          transformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={60,60}),  iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,100})));
    PlanarMechanics.Interfaces.Frame_b frame_b annotation (Placement(
          transformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={60,-60}),  iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,-100})));
  equation
    connect(brake.flange_a,rod. flange_b) annotation (Line(points={{8,-30},{8,
            -22}},                       color={0,127,0}));
    connect(booleanToReal.y,brake. f_normalized) annotation (Line(points={{-9.2,
            -40},{-3,-40}},                 color={0,0,127}));
    connect(not1.y, booleanToReal.u)
      annotation (Line(points={{-33.2,-40},{-27.6,-40}},
                                                     color={255,0,255}));
    connect(forceSensor.flange_a, rod.flange_a)
      annotation (Line(points={{8,12},{8,-2}}, color={0,127,0}));
    connect(f, forceSensor.f) annotation (Line(points={{-76,26},{-10,26},{-10,
            14},{-3,14}},
                      color={0,0,127}));
    connect(isFalling, not1.u)
      annotation (Line(points={{-72,-40},{-51.6,-40}},
                                                    color={255,0,255}));
    connect(s, add.y)
      annotation (Line(points={{-74,0},{-55,0}},    color={0,0,127}));
    connect(add.u1, relPositionSensor.s_rel)
      annotation (Line(points={{-32,6},{21,6}},   color={0,0,127}));
    connect(const.y, add.u2) annotation (Line(points={{-22.8,-6},{-32,-6}},
                      color={0,0,127}));
    connect(prismatic1.support, forceSensor.flange_b)
      annotation (Line(points={{50,30},{50,32},{8,32}}, color={0,127,0}));
    connect(relPositionSensor.flange_a, forceSensor.flange_b)
      annotation (Line(points={{32,16},{32,32},{8,32}}, color={0,127,0}));
    connect(brake.support, prismatic1.flange_a) annotation (Line(points={{18,-40},
            {32,-40},{32,24},{50,24}},
                                     color={0,127,0}));
    connect(relPositionSensor.flange_b, prismatic1.flange_a)
      annotation (Line(points={{32,-4},{32,24},{50,24}}, color={0,127,0}));
    connect(prismatic1.frame_a, frame_a) annotation (Line(
        points={{60,34},{60,60}},
        color={95,95,95},
        thickness=0.5));
    connect(prismatic1.frame_b, frame_b) annotation (Line(
        points={{60,14},{60,-60}},
        color={95,95,95},
        thickness=0.5));
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
                     graphics={
          Ellipse(
            extent={{-18,-64},{18,-98}},
            lineColor={0,0,0},
            lineThickness=1),
          Line(
            points={{12,-60}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-96,-80},{-18,-80}},
            color={217,67,180},
            thickness=0.5),
          Text(
            extent={{-80,80},{-66,46}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="F"),
          Text(
            extent={{-82,42},{-68,8}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="s"),
          Rectangle(
            extent={{-2,98},{2,-64}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
  end Rope2D;

  model RPStop
    parameter Real psiEnd = 0.1*pi "maximal amplitude for termination";
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
        Placement(transformation(
          origin={-98.832,-0.485},
          extent={{-20,-20},{20,20}},
          rotation=0), iconTransformation(extent={{-8,-8.00025},{8,8.00025}},
                                                                      origin={-100,
              -0.00025})));
    ArgesimLib.Terminator T2(psiEnd = psiEnd) annotation (Placement(transformation(
        origin={38,1},
        extent = {
            {-20, -20},
            {20, 20}},
        rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(extent={{-38,-30},{-18,-10}})));
  equation

    connect(angleSensor.flange, flange_a) annotation (Line(points={{-40,20},{-68,20},
            {-68,-0.485},{-98.832,-0.485}},
                                         color={0,0,0}));
    connect(speedSensor.flange, flange_a) annotation (Line(points={{-38,-20},{-68,
            -20},{-68,-0.485},{-98.832,-0.485}},
                                         color={0,0,0}));
    connect(speedSensor.w, T2.om) annotation (Line(points={{-17,-20},{0,-20},{0,-11},
            {18.4,-11}}, color={0,0,127}));
    connect(angleSensor.phi, T2.phi) annotation (Line(points={{-19,20},{0,20},{0,13},
            {18.4,13}},            color={0,0,127}));
    annotation (
        Diagram(
            coordinateSystem(
                preserveAspectRatio = true,
                extent = {
                    {-100, -100},
                    {100, 100}})),
        Icon(
            coordinateSystem(
                preserveAspectRatio = true,
                extent = {
                    {-100, -100},
                    {100, 100}}),
            graphics={                 Text(
            extent={{-66,66},{72,-56}},
            lineColor={28,108,200},
            textString="RPStop"),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}));
  end RPStop;

  model Terminator "Beendet die Simulation"
    parameter Real psiEnd = 0.1*pi "maximal amplitude for termination";
    Modelica.Blocks.Interfaces.RealInput phi "Winkel der Simulation" annotation (Placement(transformation(
            extent={{-122,44},{-92,74}},
            rotation = 0), iconTransformation(extent={{-108,50},{-88,70}})));
    Modelica.Blocks.Interfaces.RealInput om "Winkelgeschwindigket"  annotation (Placement(transformation(
            extent={{-122,-76},{-90,-44}},
            rotation = 0), iconTransformation(extent={{-108,-70},{-88,-50}})));
    Real psi "Abbruchwinkel";

  equation
    when {om < 0, 0 < om} then
      if abs(psi) < psiEnd then
        terminate("end swing reached");
      end if;
    end when;
    psi = mod(phi, 2 * Modelica.Constants.pi) - Modelica.Constants.pi;
    annotation (Diagram(graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
                                       Text(
            extent={{-88,58},{90,-48}},
            lineColor={28,108,200},
            textString="Terminator")}), Icon(graphics={
          Text(
            extent={{-78,84},{-46,44}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="phi"),
          Text(
            extent={{-78,-42},{-42,-70}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="om"),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
                                       Text(
            extent={{-88,58},{90,-48}},
            lineColor={28,108,200},
            textString="Terminator")}));
  end Terminator;

  model Revolute2DKick
    parameter Position radius=0.05 "Radius of animation cylinder";
    parameter Position length=0.1 "Length of animation cylinder";
    parameter RotationalDampingConstant b=1 "Rotational damping";
    parameter Angle theta0=0 "Initial angle of the revolute";
    parameter AngularVelocity om0=0 "Initial angular velocity of the revolute";
    parameter Real gamma = 50;

    PlanarMechanics.Interfaces.Frame_a frame_a annotation (Placement(
          transformation(extent={{-116,-16},{-84,16}}), iconTransformation(extent=
             {{-116,-16},{-84,16}})));
    PlanarMechanics.Interfaces.Frame_b frame_b annotation (Placement(
          transformation(extent={{84,-16},{116,16}}), iconTransformation(extent={{
              84,-16},{116,16}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
        Placement(transformation(extent={{-70,90},{-50,110}}), iconTransformation(
            extent={{-70,90},{-50,110}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
        Placement(transformation(extent={{50,90},{70,110}}), iconTransformation(
            extent={{50,90},{70,110}})));
    Modelica.Blocks.Interfaces.BooleanInput doKick annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-110}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-100})));

    PlanarMechanics.Joints.Revolute revolute(useFlange=true,
      phi(fixed=true, start=theta0),
      cylinderLength=length,
      cylinderDiameter=radius*2,
      cylinderColor={0,128,255},
      w(fixed=true, start=om0)) annotation (Placement(transformation(extent={{10,10},
              {-10,-10}})));
    Modelica.Mechanics.Rotational.Components.Damper damper1(d = b) annotation (
          Placement(visible = true, transformation(origin = {-1.1396,35.6125},
              extent={{12,-12}, {-12,12}},                                                                                                                                                         rotation = 0)));
    Angle phi;
  equation
    when doKick then
      reinit(revolute.w, revolute.w*gamma);
    end when;

    connect(revolute.support, damper1.flange_a) annotation (Line(points={{6,10},{6,
            20},{10.8604,20},{10.8604,35.6125}},      color={0,0,0}));
    connect(revolute.flange_a, damper1.flange_b) annotation (Line(points={{0,10},{
            -13.1396,10},{-13.1396,35.6125}}, color={0,0,0}));
    connect(revolute.frame_b, frame_a) annotation (Line(
        points={{-10,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_a, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(flange_a, damper1.flange_a) annotation (Line(points={{-60,100},{-60,80},
            {10.8604,80},{10.8604,35.6125}}, color={0,0,0}));
    connect(flange_b, damper1.flange_b) annotation (Line(points={{60,100},{60,60},
            {-13.1396,60},{-13.1396,35.6125}}, color={0,0,0}));
    connect(flange_a, flange_a) annotation (Line(points={{-60,100},{-100,100},{-100,
            100},{-60,100}}, color={0,0,0}));
    phi = pi/2 - revolute.phi;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            fillColor={40,118,192},
            fillPattern=FillPattern.Solid,
            points={{43,-20},{83,-52},{69,-73},{29,-41},{43,-20}}),
          Ellipse(
            fillColor={40,118,192},
            fillPattern=FillPattern.Solid,
            extent={{-50,-50},{50,50}},
            endAngle=360),
          Ellipse(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-30,-30},{30,30}},
            endAngle=360),
          Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-91,-14},{-20,12}}),
          Rectangle(
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-32,-14},{7,12}}),
          Line(points={{3,77},{17,75},{30,70},{42,63},{50,56},{59,45},{66,34},{
                72,21}}),
          Polygon(fillPattern=FillPattern.Solid, points={{64,20},{79,22},{75,-2},
                {64,20}}),
          Rectangle(extent={{-100,-100},{100,100}})}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end Revolute2DKick;

  model Rope2DmaxSS "2D rope using maximal state space"
    import PlanarMechanics.Interfaces.*;
    outer PlanarMechanics.PlanarWorld planarWorld "planar world model";
    parameter Length l = 1 "rope length";
    parameter RotationalDampingConstant k = 0.9 "damping coefficient";
    parameter Mass m = 1.5 "pendulum mass";

    Frame_b fb annotation (Placement(transformation(extent={{84,-16},{116,16}}),
          iconTransformation(extent={{84,-16},{116,16}})));
    Modelica.Blocks.Interfaces.BooleanOutput isSwinging(start=true) annotation (Placement(transformation(extent={{16,-16},
              {-16,16}},
          rotation=-90,
          origin={60,104}), iconTransformation(
          extent={{16,-16},{-16,16}},
          rotation=-90,
          origin={0,96})));

    Angle phi;
    AngularVelocity om;
    Area s "rope slack";
    Force F "rope force";
    Acceleration gx, gy;     // just abbreviations
  //   Position x, y;
  //   Velocity vx, vy;
  equation
     when F < 0 then
       isSwinging = false;
     elsewhen s <= 0 then
       isSwinging = true;
     end when;

    gx = planarWorld.g[1];
    gy = planarWorld.g[2];
    phi = fb.phi;
    om = der(phi);

    s = l^2 - fb.x^2 - fb.y^2;
    F = gx*m*sin(phi) + gy*m*cos(phi) + m*l*om^2;

    fb.t = if isSwinging then -(k/m)*om + (gx/l)*cos(phi) - (gy/l)*sin(phi) else 0;
    fb.fx = 0;
    fb.fy = 0;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),
        graphics={
          Rectangle(
            extent={{-100,6},{100,-6}},
            fillPattern=FillPattern.Solid,
            fillColor={175,175,175}),
          Text(
            extent={{72,-24},{108,-49}},
            lineColor={128,128,128},
            textString="b"),
          Text(
            extent={{-150,64},{150,24}},
            lineColor={0,0,255},
            textString="Rope2D
maxSS")}));
  end Rope2DmaxSS;

  model PointMass2D "2D point mass including trigger inputs"
    import PlanarMechanics.Interfaces.*;
    outer PlanarMechanics.PlanarWorld planarWorld "planar world model";
    parameter Mass m = 1.5 "pendulum mass";
    parameter Angle phi0 = pi/4 "initial angle";
    parameter AngularVelocity om0 = 15 "initial angular velocity";
    parameter Length l = 1 "rope length";

    Frame_a fa annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
    Modelica.Blocks.Interfaces.BooleanInput isSwinging annotation (Placement(transformation(extent={{-16,-16},
              {16,16}},
          rotation=-90,
          origin={0,106}),  iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={-28,96})));

    Position r[2](start = {l*sin(phi0),l*cos(phi0)}, fixed=true) "position of the mass";
    Velocity v[2](start = {l*om0*cos(phi0),-l*om0*sin(phi0)}, fixed=true) "velocity of the mass";
    Force f[2] "Force";
    Angle phi(start=phi0, fixed=true) "angle";
    AngularVelocity om(start=om0, fixed=true) "angular velocity";

  equation
    when not isSwinging then
      reinit(r, {l*sin(phi), l*cos(phi)});
      reinit(v, {l*om*cos(phi), -l*om*sin(phi)});
    end when;
    when isSwinging then
      reinit(phi, atan2(r[1],r[2]));
      reinit(om, (r[2]*v[1] - r[1]*v[2])/l^2);
    end when;

    r = {fa.x, fa.y};
    f = {fa.fx, fa.fy};
    phi = fa.phi;

    der(phi) = if isSwinging then om else 0;
    der(r) = if isSwinging then {0,0} else v;
    der(om) = -fa.t;
    m*der(v) = -f + m*planarWorld.g;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(
            extent={{-98,70},{42,-72}},
            fillPattern=FillPattern.Sphere,
            fillColor={85,170,255})}),
             Diagram(graphics={
          Ellipse(
            extent={{-98,70},{42,-72}},
            fillPattern=FillPattern.Sphere,
            fillColor={85,170,255})}));
  end PointMass2D;

  model AirResistance2D
    parameter TranslationalDampingConstant k = 0.9 "damping coefficient";
    PlanarMechanics.Interfaces.Frame_a  fa  annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
    Modelica.Blocks.Interfaces.BooleanInput isSwinging annotation (Placement(transformation(extent={{-16,-16},
              {16,16}},
          rotation=-90,
          origin={0,106}),  iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,96})));
    Length x, y;
  equation
    x = fa.x;
    y = fa.y;
    fa.fx = if isSwinging then 0 else -k*der(x);
    fa.fy = if isSwinging then 0 else -k*der(y);
    fa.t = 0;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
          Rectangle(
            extent={{-64,-20},{-56,-80}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-70,-22},{-50,-22},{-60,-6},{-70,-22}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-24,-20},{-16,-80}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-30,-22},{-10,-22},{-20,-6},{-30,-22}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{16,-20},{24,-80}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{10,-22},{30,-22},{20,-6},{10,-22}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{56,-20},{64,-80}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{50,-22},{70,-22},{60,-6},{50,-22}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,64},{30,8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-24}}, color={0,0,0}),
          Rectangle(
            extent={{-2,-78},{2,8}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-8,-78},{8,-78},{0,-90},{-8,-78}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AirResistance2D;

  model computeRPPlotVariables2D "computes plot variables of swinging mass"
    parameter Real l = 1 "length of the rope";
    PlanarMechanics.Interfaces.Frame_a fa annotation (Placement(transformation(extent={{-116,-16},{-84,16}}),
          iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={0,-100})));
    Modelica.Blocks.Interfaces.BooleanInput isSwinging annotation (Placement(transformation(extent={{-16,-16},
              {16,16}},
          rotation=-90,
          origin={0,106}),  iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=0,
          origin={-106,0})));
    Modelica.Blocks.Interfaces.RealOutput xP annotation (Placement(transformation(
            extent={{96,52},{116,72}}), iconTransformation(extent={{92,52},{112,72}})));
    Modelica.Blocks.Interfaces.RealOutput yP annotation (Placement(transformation(
            extent={{96,10},{116,30}}), iconTransformation(extent={{92,12},{112,32}})));
    Modelica.Blocks.Interfaces.RealOutput psi annotation (Placement(
          transformation(extent={{96,-70},{116,-50}}), iconTransformation(extent={
              {94,-70},{114,-50}})));

  equation
    xP = if isSwinging then l*sin(fa.phi) else fa.x;
    yP = if isSwinging then l*cos(fa.phi) else fa.y;
    psi = mod(fa.phi, 2*pi) - pi;
    fa.fx = 0;
    fa.fy = 0;
    fa.t = 0;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-66,98},{68,76}},
            lineColor={28,108,200},
            textString="get xP, yP, psi"),
          Ellipse(
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            extent={{-70.0,-70.0},{70.0,70.0}}),
          Ellipse(
            lineColor={64,64,64},
            fillColor={255,255,255},
            extent={{-12.0,-12.0},{12.0,12.0}}),
          Ellipse(
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-7.0,-7.0},{7.0,7.0}}),
          Polygon(
            rotation=-17.5,
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
          Line(points={{-37.6,13.7},{-65.8,23.9}}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}),
          Line(points={{0.0,70.0},{0.0,40.0}}),
          Line(points={{22.9,32.8},{40.2,57.3}}),
          Line(points={{37.6,13.7},{65.8,23.9}}),
          Line(points={{-92,0},{-70,0}}, color={217,67,180}),
          Line(points={{54,-46}}, color={0,0,0}),
          Line(points={{0,-70},{0,-94}}, color={0,0,0})}),         Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end computeRPPlotVariables2D;

  model SwitchablePendulum "pendulum that can be restarted"
    extends Utilities.SwitchableSystem;
    parameter Real k = 0.9;
    parameter Real l = 1;
    parameter Real m = 1.5;
    parameter Real g = 9.81;
    parameter Real psiEnd = 0.1*pi "maximal amplitude for termination";
    Real psi;

  equation
    if active then
      der(state) = {state[2], -(k/m)*state[2] + (g/l)*sin(state[1])};
    else
      der(state) = zeros(N);
    end if;
    when {state[2] < 0, 0 < state[2]} then
      if abs(psi) < psiEnd then
        terminate("end swing reached");
      end if;
    end when;
    psi = mod(state[1], 2*pi)- pi;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-84,52},{82,-40}},
            lineColor={28,108,200},
            textString="Pendulum")}),                              Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SwitchablePendulum;

  model SwitchableFreefall "free fall that can be switched on and off"
    extends Utilities.SwitchableSystem;
    parameter Real k = 0.9;
    parameter Real m = 1.5;
    parameter Real g = 9.81;
  equation
    if active then
      der(state) = {state[3], state[4], -(k/m)*state[3], -(k/m)*state[4] - g};
    else
      der(state) = zeros(N);
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-80,50},{76,-44}},
            lineColor={28,108,200},
            textString="Freefall")}),                              Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SwitchableFreefall;

  model SwitchablePendulumKick
    "pendulum that can be restarted, with internal kick"
    parameter Integer N = 2 "number of state variables";
    parameter Real[N] s0 = {pi/4, 15};
    parameter Real k = 0.9;
    parameter Real l = 1;
    parameter Real m = 1.5;
    parameter Real g = 9.81;
    parameter Real psiEnd = 0.1*pi "maximal amplitude for termination";
    parameter Real gamma = 7;

    Modelica.Blocks.Interfaces.RealInput[N] newState annotation (Placement(transformation(
            extent={{-128,40},{-88,80}}), iconTransformation(extent={{-120,40},{-80,
              80}})));
    Modelica.Blocks.Interfaces.BooleanInput active annotation (Placement(
          transformation(extent={{-128,-82},{-88,-42}}),
                                                       iconTransformation(extent={
              {-120,-80},{-80,-40}})));
    Modelica.Blocks.Interfaces.RealOutput[N] stateOut annotation (Placement(transformation(
            extent={{96,50},{116,70}}),    iconTransformation(extent={{90,50},{110,
              70}})));

    Real[N] state(start=s0, each fixed=true, each stateSelect=StateSelect.always);
    Real psi;
    Boolean awaitKick(start = false, fixed = true);
    Boolean doKick(start = false, fixed = true);

  equation
    when active then
      reinit(state, pre(newState));
    elsewhen doKick then
      reinit(state[2], gamma * state[2]);
    end when;

    stateOut = if active then state else zeros(N);

    if active then
      der(state) = {state[2], -(k/m)*state[2] + (g/l)*sin(state[1])};
    else
      der(state) = zeros(N);
    end if;

    when {state[2] < 0, state[2] > 0} then
      if abs(psi) < psiEnd then
        awaitKick = true;
      else
        awaitKick = false;
      end if;
    end when;

    when psi < 0 and awaitKick then
      doKick = true;
    end when;

    psi = mod(state[1], 2*pi)- pi;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-136,70},{134,-66}},
            lineColor={28,108,200},
            textString="Pendulum
Kick")}),   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end SwitchablePendulumKick;

  model SwitchablePendulumKickM
    "pendulum that can be restarted, with internal kick, MapleSim version"
    extends Utilities.SwitchableSystem;
    parameter Real k = 0.9;
    parameter Real l = 1;
    parameter Real m = 1.5;
    parameter Real g = 9.81;
    parameter Real psiEnd = 0.1*pi "maximal amplitude for termination";
    parameter Real gamma = 7;
    Real psi;
    Boolean awaitKick(start = false, fixed = true);
    Boolean doKick(start = false, fixed = true);

  equation
    if active then
      der(state) = {state[2], -(k/m)*state[2] + (g/l)*sin(state[1])};
    else
      der(state) = zeros(N);
    end if;

    when {state[2] < 0, state[2] > 0} then
      if abs(psi) < psiEnd then
        awaitKick = true;
      // workaround for MapleSim bug: comment these two lines
      // else
      // awaitKick = false;
      end if;
    end when;

    when psi < 0 and awaitKick then
      doKick = true;
    end when;

    when doKick then
      reinit(state[2], gamma * state[2]);
    end when;

    psi = mod(state[1], 2*pi)- pi;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-128,66},{124,-66}},
            lineColor={28,108,200},
            textString="Pendulum
Kick")}),   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end SwitchablePendulumKickM;

  model SystemSwitch
    extends Utilities.PartialSystemSwitch(N1=2, N2=4);
    parameter Real l = 1;
    parameter Real m = 1.5;
    parameter Real g = 9.81;

  equation
    h1 = -g*m*cos(state1[1]) + m*l*state1[2]^2;
    h2 = l^2 - state2[1]^2 - state2[2]^2;

    new2[1] = l*sin(state1[1]);
    new2[2] = l*cos(state1[1]);
    new2[3] = l*state1[2]*cos(state1[1]);
    new2[4] = -l*state1[2]*sin(state1[1]);

    new1[1] = atan2(state2[1],state2[2]);
    new1[2] = (state2[2]*state2[3] - state2[1]*state2[4])/l^2;
  end SystemSwitch;

  model SwitchablePendulum2D "pendulum that can be restarted"
    extends Utilities.SwitchableSystem;
    parameter Real k = 0.9;
    parameter Real l = 1;
    parameter Real m = 1.5;
    parameter Real g = 9.81;

    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-30,50})));
    PlanarMechanics.Parts.Body body(m=m, I=0)      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-30,-26})));
    PlanarMechanics.Joints.Revolute revolute(useFlange=true)  annotation (Placement(transformation(extent={{-10,10},
              {10,-10}},
          rotation=-90,
          origin={-30,26})));
    Modelica.Mechanics.Rotational.Components.Damper damper1(d=k) annotation(Placement(visible = true, transformation(origin={8.8604,
              25.6125},                                                                                                                            extent = {{-12,-12},{12,12}}, rotation=-90)));
    inner PlanarMechanics.PlanarWorld planarWorld  annotation (Placement(transformation(extent={{-10,-24},
              {10,-4}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={l,0}) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-30,0})));

  equation
     state[1] = pi/2 - revolute.phi;
     state[2] = -revolute.w;

    connect(revolute.support,damper1. flange_a) annotation (Line(points={{-20,32},
            {-20,46},{8.8604,46},{8.8604,37.6125}},   color={0,0,0}));
    connect(revolute.flange_a,damper1. flange_b) annotation (Line(points={{-20,26},
            {-20,8},{8.8604,8},{8.8604,13.6125}},
                                            color={0,0,0}));
    connect(revolute.frame_a, fixed.frame) annotation (Line(
        points={{-30,36},{-30,40}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{-30,-10},{-30,-16}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_a, revolute.frame_b) annotation (Line(
        points={{-30,10},{-30,16}},
        color={95,95,95},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-102,52},{100,-50}},
            lineColor={28,108,200},
            textString="Pendulum
 2D")}),            Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SwitchablePendulum2D;

  model SwitchableFreefall2D "free fall that can be switched on and off"
    extends Utilities.SwitchableSystem(N=4);
    parameter Real k = 0.9;
    parameter Real l = 1;
    parameter Real m = 1.5;
    parameter Real g = 9.81;

    PlanarMechanics.Parts.Body body(m=m, I=1)      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={4,0})));
    inner PlanarMechanics.PlanarWorld planarWorld  annotation (Placement(transformation(extent={{42,56},
              {62,76}})));
    PlanarMechanics.Sources.WorldForce worldForce(animation=false) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={4,36})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-20,18})));
    Modelica.Blocks.Math.MatrixGain matrixGain(K=(-k)*[1,0,0; 0,1,0; 0,0,0])
                                                                  annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-46,44})));

  equation
    state[1] = body.r[1];
    state[2] = body.r[2];
    state[3] = body.v[1];
    state[4] = body.v[2];

    connect(worldForce.frame_b, body.frame_a) annotation (Line(
        points={{4,26},{4,10}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
        points={{-10,18},{4,18},{4,10}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.v, matrixGain.u) annotation (Line(points={{-31,18},{-46,18},{-46,32}}, color={0,0,127}));
    connect(matrixGain.y, worldForce.force) annotation (Line(points={{-46,55},{-46,
            66},{4,66},{4,48}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-96,58},{92,-54}},
            lineColor={28,108,200},
            textString="Freefall
2D")}),                                                            Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SwitchableFreefall2D;

  model computeRPPlotVariables
    "computes plot variables of swinging mass"
    parameter Real l = 1 "length of the rope";
    Modelica.Blocks.Interfaces.BooleanInput isSwinging annotation (Placement(transformation(extent={{-16,-16},
              {16,16}},
          rotation=-90,
          origin={0,106}),  iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=0,
          origin={-106,0})));
    Modelica.Blocks.Interfaces.RealOutput xP annotation (Placement(transformation(
            extent={{96,52},{116,72}}), iconTransformation(extent={{92,52},{112,72}})));
    Modelica.Blocks.Interfaces.RealOutput yP annotation (Placement(transformation(
            extent={{96,10},{116,30}}), iconTransformation(extent={{92,12},{112,32}})));
    Modelica.Blocks.Interfaces.RealOutput psi annotation (Placement(
          transformation(extent={{96,-70},{116,-50}}), iconTransformation(extent={
              {94,-70},{114,-50}})));

    Modelica.Blocks.Interfaces.RealInput[2] s1 annotation (Placement(
          transformation(extent={{-130,20},{-90,60}}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,-100})));
    Modelica.Blocks.Interfaces.RealInput[4] s2 annotation (Placement(
          transformation(extent={{-130,-60},{-90,-20}}),
                                                       iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={60,-100})));
  equation
    xP = if isSwinging then l*sin(s1[1]) else s2[1];
    yP = if isSwinging then l*cos(s1[1]) else s2[2];
    psi = mod(s1[1], 2*pi) - pi;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
            extent={{-66,98},{68,76}},
            lineColor={28,108,200},
            textString="get xP, yP, psi"),
          Ellipse(
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            extent={{-70.0,-70.0},{70.0,70.0}}),
          Ellipse(
            lineColor={64,64,64},
            fillColor={255,255,255},
            extent={{-12.0,-12.0},{12.0,12.0}}),
          Ellipse(
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-7.0,-7.0},{7.0,7.0}}),
          Polygon(
            rotation=-17.5,
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
          Line(points={{-37.6,13.7},{-65.8,23.9}}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}),
          Line(points={{0.0,70.0},{0.0,40.0}}),
          Line(points={{22.9,32.8},{40.2,57.3}}),
          Line(points={{37.6,13.7},{65.8,23.9}}),
          Line(points={{-92,0},{-70,0}}, color={217,67,180}),
          Line(points={{54,-46}}, color={0,0,0}),
          Line(points={{0,-70},{0,-94}}, color={0,0,0})}),         Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end computeRPPlotVariables;

  package ModelicaModels

    model BBevfMod1 "after Fritzson 2015, p.57"
      constant Real g = 9.81  "Gravity constant";
      parameter Real mu = 0.9 "Coefficient of restitution";
      Real x(start = 10, fixed=true) "bottom position of the ball";
      Real v(start = 0, fixed=true) "velocity of the ball";
    equation
      der(x) = v;
      der(v) = -g;
      when x <= 0 then
        reinit(v, -mu*pre(v));
      end when;
      annotation (experiment(StopTime=30, Interval=0.01));
    end BBevfMod1;

    model BBevfMod2 "after Modelica 3.4, p.96"
      parameter Real g = 9.81  "Gravity constant";
      parameter Real mu = 0.9 "Coefficient of restitution";
      Real x(start = 10, fixed=true) "bottom position of the ball";
      Real v(start = 0, fixed=true) "velocity of the ball";
      Boolean flying;

    equation
      flying = not (x<=0 and v<=0);
      der(x) = v;
      der(v) = if flying then -g else 0;
      when x <= 0 then
        reinit(v, -mu*pre(v));
      end when;
      annotation (experiment(StopTime=30));
    end BBevfMod2;

    model BBevaMod1 "BBevfMod1 with beta"
      constant Real g = 9.81  "Gravity constant";
      parameter Real mu = 0.9 "Coefficient of restitution";
      parameter Real beta = 0.002 "Air resistance";
      Real x(start = 10, fixed=true) "Bottom position of the ball";
      Real v(start = 0, fixed=true) "Velocity of the ball";
    equation
      der(x) = v;
      der(v) = -g -beta*sign(v)*v^2;
      when x <= 0 then
        reinit(v, -mu*pre(v));
      end when;
    end BBevaMod1;

    model BBevaMod2 "BBevfMod2 with beta"
      constant Real g = 9.81  "Gravity constant";
      parameter Real mu = 0.9 "Coefficient of restitution";
      parameter Real beta = 0.002 "Air resistance";
      Real x(start = 10, fixed=true) "bottom position of the ball";
      Real v(start = 0, fixed=true) "velocity of the ball";

      Boolean flying;

    equation
      flying = not (x<=0 and v<=0);
      der(x) = v;
      der(v) = if flying then -g - beta*sign(v)*v^2 else 0;
      when x <= 0 then
        reinit(v, -mu*pre(v));
      end when;
    end BBevaMod2;

    model BBccfMod1
      parameter Real g = 9.81  "Gravity constant";
      parameter Real k = 1e6 "spring stiffness";
      parameter Real d = 500 "damping coefficient";

      Real x(start = 10, fixed=true) "bottom position of the sphere";
      Real w(start = 0, fixed=true) "deformation of the ball";
      Real v(start = 0, fixed=true) "velocity of the ball";

      Boolean hasContact(start=false);
      Boolean flyRestarted(start=false);
      Real fc, fcOut, y;
    equation
      fc = -k*x - d*v;
      y = x + w;
      hasContact = (y <= 0);
      flyRestarted = (fc <= 0);
      der(x) = v;
      der(v) = if (hasContact and not flyRestarted) then -g + fc else -g;
      der(w) = if (hasContact and not flyRestarted) then -v else -(k/d)*w;
      fcOut = max(fc, 0);
    end BBccfMod1;

    model BBccfMod2
      parameter Real g = 9.81  "Gravity constant";
      parameter Real k = 1e6 "spring stiffness";
      parameter Real d = 500 "damping coefficient";
      Real x(start = 10, fixed=true) "bottom position of the sphere";
      Real w(start = 0, fixed=true) "deformation of the ball";
      Real v(start = 0, fixed=true) "velocity of the ball";
      Boolean hasContact(start=false);
      Boolean flyRestarted(start=false);
      Real fc;
    equation
      fc = max(-k*x - d*v, 0);
      hasContact = (x+w<=0);
      flyRestarted = (fc <= 0);
      der(x) = v;
      der(v) = if (hasContact and not flyRestarted) then -g + fc else -g;
      der(w) = if (hasContact and not flyRestarted) then -v else -(k/d)*w;
      annotation (experiment(StopTime=10));
    end BBccfMod2;

    model BBccaMod1
      parameter Real g = 9.81  "Gravity constant";
      parameter Real k = 1e6 "spring stiffness";
      parameter Real d = 500 "damping coefficient";
      parameter Real beta = 0.002 "air resistance";
      Real x(start = 10, fixed=true) "bottom position of the sphere";
      Real w(start = 0, fixed=true) "deformation of the ball";
      Real v(start = 0, fixed=true) "velocity of the ball";

      Boolean hasContact(start=false);
      Boolean flyRestarted(start=false);
      Real fc, fcOut, y;
    equation
      fc = -k*x - d*v;
      y = x + w;
      hasContact = (y <= 0);
      flyRestarted = (fc <= 0);
      der(x) = v;
      der(v) = if (hasContact and not flyRestarted) then -g + fc else -g - beta*v*v*sign(v);
      der(w) = if (hasContact and not flyRestarted) then -v else -(k/d)*w;
      fcOut = max(fc, 0);
      annotation (experiment(
          StopTime=5,
          __Dymola_NumberOfIntervals=100000,
          Tolerance=1e-10));
    end BBccaMod1;

    model DIscMod1
      constant Real pi = Modelica.Constants.pi;
      parameter Resistance R1 = 1e3;
      parameter Resistance R2 = 2e1;
      parameter Inductance L = 25.3e-6;
      parameter Capacitance C = 100e-9;
      parameter Frequency f = 0.15e6;
      Voltage uC(start = 0, fixed = true);
      Current i(start = 0, fixed = true);
      Voltage u0;
      Boolean locking;
      Voltage uD;
      Current iD;

    equation
      u0 = -sin(2*pi*f*time);
      locking = (R2*i + uC >= 0);
      der(uC) = if locking then i/C else -uC/(C*R2);
      der(i) = if locking then (-(R1+R2)*i - uC + u0)/L else (-R1*i + u0)/L;
      iD = if locking then 0 else -i - uC/R2;
      uD = if locking then -uC - R2*i else 0;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=0.0001, __Dymola_NumberOfIntervals=2000));
    end DIscMod1;

    model DIshiMod1
      constant Real pi = Modelica.Constants.pi;
      parameter Resistance R1 = 1e3;
      parameter Resistance R2 = 2e1;
      parameter Inductance L = 25.3e-6;
      parameter Capacitance C = 100e-9;
      parameter Frequency f = 0.15e6;
      parameter Current IS = 1e-8;
      parameter Voltage UT = 26e-3;
      Voltage uC(start = 0, fixed = true);
      Current i(start = 0, fixed = true);
      Current iD(start = 0);
      Voltage u0;
      Boolean locking;
      Voltage uD;

    equation
      u0 = -sin(2*pi*f*time);
      locking = (R2*(i + iD) + uC > 0);
      der(uC) = if locking then i/C else i/C + iD/C;
      der(i) = if locking then (-(R1+R2)*i - uC + u0)/L
                          else (-R1*i - R2*(i + iD) - uC + u0)/L;
      0 = if locking then R2*iD else R2*(i + iD) + uC + UT*log(1 + iD/IS);
      uD = if locking then -(uC + R2*i) else UT*log(1 + iD/IS);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=0.0001, __Dymola_NumberOfIntervals=2000));
    end DIshiMod1;

    model DIshuMod1
      constant Real pi = Modelica.Constants.pi;
      parameter Resistance R1 = 1e3;
      parameter Resistance R2 = 2e1;
      parameter Inductance L = 25.3e-6;
      parameter Capacitance C = 100e-9;
      parameter Frequency f = 0.15e6;
      parameter Current IS = 1e-8;
      parameter Voltage UT = 26e-3;
      Voltage uC(start = 0, fixed = true);
      Current i(start = 0, fixed = true);
      Voltage uD(start = 0);
      Voltage u0;
      Boolean locking;
      Current iD;

    equation
      u0 = -sin(2*pi*f*time);
      locking = (R2*(i + IS*(exp(uD/UT) - 1)) + uC > 0);
      der(uC) = if locking then i/C else i/C + IS/C*(exp(uD/UT) - 1);
      der(i) = if locking then (-(R1+R2)*i - uC + u0)/L
                          else (-R1*i - R2*(i + IS*(exp(uD/UT) - 1)) - uC + u0)/L;
      if locking then
        uD = -(uC + R2*i);
      else
         0 = R2*(i + IS*(exp(uD/UT) - 1)) + uC + uD;
      end if;
      iD = if locking then 0 else IS*(exp(uD/UT) - 1);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=0.0001, __Dymola_NumberOfIntervals=2000));
    end DIshuMod1;

    model DIesMod1
      constant Real pi = Modelica.Constants.pi;
      parameter Resistance R1 = 1e3;
      parameter Resistance R2 = 2e1;
      parameter Inductance L = 25.3e-6;
      parameter Capacitance C = 100e-9;
      parameter Frequency f = 0.15e6;
      parameter Current IS = 1e-8;
      parameter Voltage UT = 26e-3;
      Voltage uC(start = 0, fixed = true);
      Current i(start = 0, fixed = true);
      Voltage uD(start = 0, fixed = true);
      Voltage u0;
      Boolean locking;
      Voltage uDOut;
      Current iDOut;

    equation
      u0 = -sin(2*pi*f*time);
      locking = (R2*(i + IS*(exp(uD/UT) - 1)) + uC > 0);
      der(uC) = if locking then i/C else i/C + IS/C*(exp(uD/UT) - 1);
      der(i) = if locking then (-(R1+R2)*i - uC + u0)/L
                          else (-R1*i - R2*(i + IS*(exp(uD/UT) - 1)) - uC + u0)/L;
      if locking then
        der(uD) = 0;
      else
        der(uD) = (((R1+R2)*R2/L - 1/C)*i + (R2^2/L - 1/C)*IS*(exp(uD/UT) - 1)
                        + R2/L*uC - R2/L*u0)/((R2*IS/UT)*exp(uD/UT) + 1);
      end if;
      iDOut = if locking then 0 else IS*(exp(uD/UT) - 1);
      uDOut = if locking then -(uC + R2*i) else uD;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=0.0001,
          __Dymola_NumberOfIntervals=2000,
          Tolerance=1e-06,
          __Dymola_fixedstepsize=1e-08,
          __Dymola_Algorithm="Rkfix4"));
    end DIesMod1;

    model DIesMod2
      constant Real pi = Modelica.Constants.pi;
      parameter Resistance R1 = 1e3;
      parameter Resistance R2 = 2e1;
      parameter Inductance L = 25.3e-6;
      parameter Capacitance C = 100e-9;
      parameter Frequency f = 0.15e6;
      parameter Current IS = 1e-8;
      parameter Voltage UT = 26e-3;
      Voltage uC(start = 0, fixed = true);
      Current i(start = 0, fixed = true);
      Voltage uD(start = 0, fixed = true);
      Voltage u0;
      Boolean locking;
      Voltage uDOut;
      Current iDOut;

    equation
      u0 = -sin(2*pi*f*time);
      locking = (R2*(i + IS*(exp(uD/UT) - 1)) + uC > 0);
      der(uC) = if locking then i/C else i/C + IS/C*(exp(uD/UT) - 1);
      der(i) = if locking then (-(R1+R2)*i - uC + u0)/L
                          else (-R1*i - R2*(i + IS*(exp(uD/UT) - 1)) - uC + u0)/L;
      if locking then
        der(uD) = 0;
      else
        der(uD) = -(R2*der(i) + der(uC))/((R2*IS/UT)*exp(uD/UT) + 1);
      end if;

      iDOut = if locking then 0 else IS*(exp(uD/UT) - 1);
      uDOut = if locking then -(uC + R2*i) else uD;
      annotation (experiment(StopTime=0.0001));
    end DIesMod2;

    model RPfrMod1
      constant Real pi = Modelica.Constants.pi;
      parameter Real g = 9.81  "gravity constant";
      parameter Real m = 1.5 "pendulum mass";
      parameter Real l = 1 "rope length";
      parameter Real k = 0.9 "damping coefficient";
      parameter Real phi0 = pi/4 "initial angle";
      parameter Real om0 = 15 "initial angular velocity";

      Real x(start=l*sin(phi0), fixed=true) "x position of the mass";
      Real y(start=l*cos(phi0), fixed=false) "y position of the mass";
      Real vx(start=l*om0*cos(phi0), fixed=true) "x velocity of the mass";
      Real vy(start=-l*om0*sin(phi0), fixed=false) "y velocity of the mass";
      Real lambda "constraining variable";
      Real F "constraining force";
      Real s(start=0, fixed=true) "rope slack";
      Boolean isFalling(start=false);
      Boolean isSwinging(start=true);
    equation
      s = l^2 - x^2 - y^2;
      F = -g*m*y/l + (m/l)*(vx^2 + vy^2);
      isFalling = (s > 0);
      isSwinging = (F > 0);
      if isSwinging then
        s = 0;
      else
        lambda = 0;
      end if;
      der(x) = vx;
      der(y) = vy;
      m*der(vx) = -k*vx - lambda*x;
      m*der(vy) = -k*vy - lambda*y - m*g;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10,
          __Dymola_NumberOfIntervals=2000,
          Tolerance=1e-10,
          __Dymola_Algorithm="Dassl"));
    end RPfrMod1;

    model RPfrMod2 "maximal state space approach"
      import Modelica.Constants.pi;
      parameter Real g = 9.81  "gravity constant";
      parameter Real m = 1.5 "pendulum mass";
      parameter Real l = 1 "rope length";
      parameter Real k = 0.9 "damping coefficient";
      parameter Real phi0 = pi/4 "initial angle";
      parameter Real om0 = 15 "initial angular velocity";
      parameter Real psiEnd = pi/10 "maximal amplitude for termination";

      Real x(start=l*sin(phi0)) "x position of the mass";
      Real y(start=l*cos(phi0)) "y position of the mass";
      Real vx(start=l*om0*cos(phi0)) "x velocity of the mass";
      Real vy(start=-l*om0*sin(phi0)) "y velocity of the mass";
      Real phi(start=phi0, fixed=true) "angle";
      Real om(start=om0, fixed=true) "angular velocity";
      Real s "rope slack";
      Real F "rope force";
      Boolean isSwinging;
      Real xP, yP;     // plot variables
      Real psi;        // phi - pi mod 2 pi
    equation
      when {om < 0, om > 0} then
        if abs(psi) < psiEnd then
          terminate("end swing reached");
        end if;
      end when;
      when not isSwinging then
        reinit(x, l*sin(phi));
        reinit(y, l*cos(phi));
        reinit(vx, l*om*cos(phi));
        reinit(vy, -l*om*sin(phi));
      end when;
      when s < 0 then
        reinit(phi, atan2(x,y));
        reinit(om, (y*vx - x*vy)/l^2);
      end when;

      s = l^2 - x^2 - y^2;
      F = -g*m*cos(phi) + m*l*om^2;
      psi = mod(phi, 2*pi) - pi;

      isSwinging = (F >= 0);
      if isSwinging then
        der(phi) = om;
        der(om) = -(k/m)*om + (g/l)*sin(phi);
        der(x) = 0;
        der(y) = 0;
        m*der(vx) = 0;
        m*der(vy) = 0;
        xP = l*sin(phi);
        yP = l*cos(phi);
      else
        der(phi) = 0;
        der(om) = 0;
        der(x) = vx;
        der(y) = vy;
        m*der(vx) = -k*vx;
        m*der(vy) = -k*vy - m*g;
        xP = x;
        yP = y;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10,
          __Dymola_NumberOfIntervals=2000,
          Tolerance=1e-10,
          __Dymola_Algorithm="Dassl"));
    end RPfrMod2;

    model RPkiMod2 "maximal state space approach with kick"
      constant Real pi = Modelica.Constants.pi;
      parameter Real g = 9.81  "gravity constant";
      parameter Real m = 1.5 "pendulum mass";
      parameter Real l = 1 "rope length";
      parameter Real k = 0.9 "damping coefficient";
      parameter Real phi0 = pi/4 "initial angle";
      parameter Real om0 = 15 "initial angular velocity";
      parameter Real psiEnd = pi/10 "maximal amplitude for termination";
      parameter Real gamma = 9 "kick of angular velocity";

      Real x(start=l*sin(phi0)) "x position of the mass";
      Real y(start=l*cos(phi0)) "y position of the mass";
      Real vx(start=l*om0*cos(phi0)) "x velocity of the mass";
      Real vy(start=-l*om0*sin(phi0)) "y velocity of the mass";
      Real phi(start=phi0, fixed=true) "angle";
      Real om(start=om0, fixed=true) "angular velocity";
      Real s "rope slack";
      Real F "rope force";
      Boolean isSwinging(start=true);
      Real xP, yP;     // plot variables
      Real psi;        // phi - pi mod 2 pi
      Boolean awaitKick(start=false, fixed=true);  // true, when kick is due soon
      Boolean doKick(start=false, fixed=true);     // true at moment of kick

    equation
      when psi < 0 and awaitKick then
        doKick = true;
      end when;

      when {om < 0, om > 0} then
        if abs(psi) < psiEnd then
          awaitKick = true;
        else
          awaitKick = false;
        end if;
      end when;

      when doKick then
        reinit(om, gamma*om);
      elsewhen s < 0 then
        reinit(phi, atan2(x,y));
        reinit(om, (y*vx - x*vy)/l^2);
      end when;

      when F < 0 then
        reinit(x, l*sin(phi));
        reinit(y, l*cos(phi));
        reinit(vx, l*om*cos(phi));
        reinit(vy, -l*om*sin(phi));
      end when;

      s = l^2 - x^2 - y^2;
      F = -g*m*cos(phi) + m*l*om^2;
      psi = mod(phi, 2*pi) - pi;

      isSwinging = (F > 0);
      if isSwinging then
        der(phi) = om;
        der(om) = -(k/m)*om + (g/l)*sin(phi);
        der(x) = 0;
        der(y) = 0;
        m*der(vx) = 0;
        m*der(vy) = 0;
        xP = l*sin(phi);
        yP = l*cos(phi);
      else
        der(phi) = 0;
        der(om) = 0;
        der(x) = vx;
        der(y) = vy;
        m*der(vx) = -k*vx;
        m*der(vy) = -k*vy - m*g;
        xP = x;
        yP = y;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=15,
          __Dymola_NumberOfIntervals=2000,
          Tolerance=1e-10,
          __Dymola_Algorithm="Dassl"));
    end RPkiMod2;
  end ModelicaModels;

  package Utilities
    function findIndex "returns interval such that x is in [X(n), X(n+1)]"
      input Real x;
      input Real X[:];
      output Integer idx;
    protected
      Integer n, i0, i1, ih;
    algorithm
      n := size(X,1);
      if x <= X[1] then
        idx := 0;
      elseif x >= X[n] then
        idx := n;
      else     // binary search
        i0 := 1;
        i1 := n;
        while i1 > i0 + 1 loop
          ih := integer((i0 + i1)/2);
          if x < X[ih] then
            i1 := ih;
          else
            i0 := ih;
          end if;
        end while;
        idx := i0;
      end if;
    end findIndex;

    function linInterp "computes linear interpolation"
      // constant extrapolation
      // assumptions
      //   X, Y are vectors of equal length
      //   values in X are monotonously increasing
      input Real x "input value";
      input Real X[:] "x values of breakpoints";
      input Real Y[:] "y values of breakpoints";
      output Real y "result";
    protected
      Integer n, idx;
      Real x1, x2, y1, y2;
    algorithm
      n := size(X,1);
      idx := Utilities.findIndex(x, X);
      if idx == 0 then
        y := Y[1];
      elseif idx == n then
        y := Y[n];
      else
        x1 := X[idx];
        x2 := X[idx+1];
        y1 := Y[idx];
        y2 := Y[idx+1];
        y := (y2 - y1)/(x2 - x1)*(x - x1) + y1;
      end if;
    end linInterp;

    partial model SwitchableSystem
      "dynamic system that can be switched on and off"
      parameter Integer N = 2 "number of state variables";
      parameter Real[N] s0 = {pi/4, 15};
      parameter Real[N] sOff = zeros(N);
      Real[N] state(start=s0, each fixed=true, each stateSelect=StateSelect.always);

      Modelica.Blocks.Interfaces.RealInput[N] newState annotation (Placement(transformation(
              extent={{-128,40},{-88,80}}), iconTransformation(extent={{-120,40},{-80,
                80}})));
      Modelica.Blocks.Interfaces.BooleanInput active annotation (Placement(
            transformation(extent={{-128,-82},{-88,-42}}),
                                                         iconTransformation(extent={
                {-120,-80},{-80,-40}})));
      Modelica.Blocks.Interfaces.RealOutput[N] stateOut annotation (Placement(transformation(
              extent={{96,50},{116,70}}),    iconTransformation(extent={{90,50},{110,
                70}})));

    equation
      when active then
        reinit(state, pre(newState));
      end when;
      stateOut = if active then state else sOff;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SwitchableSystem;

    model PartialSystemSwitch "generic switch between two systems"
      parameter Integer N1 = 2 "number of state1 variables";
      parameter Integer N2 = 2 "number of state2 variables";
      parameter Boolean startWith1 = true;

      Modelica.Blocks.Interfaces.RealInput[N1] state1 annotation (Placement(
            transformation(extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-110}),                          iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-100})));
      Modelica.Blocks.Interfaces.RealInput[N2] state2 annotation (Placement(
            transformation(extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-110}),                           iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-100})));
      Modelica.Blocks.Interfaces.RealOutput[N1] new1 annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-58,106}),                            iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,102})));
      Modelica.Blocks.Interfaces.RealOutput[N2] new2 annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,106}),                             iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,102})));
      Modelica.Blocks.Interfaces.BooleanOutput active1(start=startWith1, fixed=true) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,106}),                            iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,102})));
      Modelica.Blocks.Interfaces.BooleanOutput active2 annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={54,106}),                             iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={62,102})));

      Real h1, h2;  // event variables for switching from 1 to 2 or vice versa

    equation
      when h1 < 0 then
        active1 = false;
      elsewhen h2 < 0 then
        active1 = true;
      end when;
      active2 = not active1;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
              Text(
              extent={{-126,46},{128,-30}},
              lineColor={28,108,200},
              textString="System
Switch")}),     Diagram(coordinateSystem(preserveAspectRatio=false)));
    end PartialSystemSwitch;
  end Utilities;
  annotation (uses(Modelica(version="3.2.2"), PlanarMechanics(version="1.4.0")));
end ArgesimLib;
