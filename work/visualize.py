import numpy
import plotly.figure_factory as figure_factory
import plotly.graph_objs as graph_objs
import plotly.offline as offline
import plotly.plotly as py

# Configure plotly to run in offline mode
offline.init_notebook_mode(connected=False)

def bar_chart(columns, title="", x_axis=""):
    """Takes an array of dictionaries that have the keys 'column' and 'score'.
    The value for the 'column' key is a string representing the name of the column.
    The value for the 'score' key is an integer.
    """
    short_names = (column['column'][:40] for column in columns)
    truncated_names = ['{}…'.format(name) if len(name) > 40 else name
                       for name in short_names]
    scores = [column['score'] for column in columns]

    data = [graph_objs.Bar(
        x=scores,
        y=truncated_names,
        orientation = 'h'
    )]

    layout = graph_objs.Layout(
        margin=graph_objs.layout.Margin(),
        title=title,
        yaxis=dict(
            tickfont=dict(
                size=9,
                color='rgb(107, 107, 107)'
            ),
            tickangle=30,
            automargin=True
        ),
        xaxis=dict(title=x_axis)
    )

    return graph_objs.Figure(data=data, layout=layout)

def choropleth(fips=[], values=[], title='', legend_title=None, color_scale=None):
    assert len(fips) == len(values), 'Length of fips ({}) and length of values ({}) do not match.'.format(len(fips), len(values))

    default_color_scale = ["#f7fbff","#ebf3fb","#deebf7","#d2e3f3","#c6dbef","#b3d2e9","#9ecae1",
                           "#85bcdb","#6baed6","#57a0ce","#4292c6","#3082be","#2171b5","#1361a9",
                           "#08519c","#0b4083","#08306b"]
    default_color_scale.reverse()
    color_scale = color_scale or default_color_scale

    binning_endpoints = list(numpy.linspace(min(values), max(values), len(color_scale) - 1))

    return figure_factory.create_choropleth(
        fips=fips,
        values=values,
        scope=['usa'],
        colorscale=color_scale,
        binning_endpoints=binning_endpoints,
        county_outline={
            'color': 'rgb(15, 15, 55)',
            'width': 0.5
        },
        show_hover=True,
        centroid_marker={'opacity': 0},
        asp=2.9,
        title=title,
        showlegend=(legend_title is not None),
        **(dict(legend_title=legend_title) if legend_title else {})
    )

def scatterplot(xs=[], ys=[], text=[], title='', x_axis='', y_axis=''):
    assert len(xs) == len(ys) == len(text),\
        'Length of xs ({}) and ys ({}) and text ({}) must match.'.format(len(xs), len(ys), len(text))

    trace = graph_objs.Scatter(
        x=xs,
        y=ys,
        text=text,
        mode='markers'
    )

    layout = graph_objs.Layout(
        title=title,
        hovermode='closest',
        xaxis=dict(title=x_axis),
        yaxis=dict(title=y_axis),
        showlegend= False
    )

    return graph_objs.Figure(data=[trace], layout=layout)
